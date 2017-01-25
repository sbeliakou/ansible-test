#!/bin/bash -e
#
# Tests that a new version of ansible playbooks will not
# break everything by deploying it twice.
#


#
# Mimic AT&T environment (users & dirs)
#
groupadd deployadmin
useradd ansible -m -G deployadmin
useradd deploy -m -G deployadmin

make_att_dir() { mkdir -p -m 775 "$1" && chown root:deployadmin "$1"; }
make_att_dir /etc/ansible/facts.d
make_att_dir /tmp/deploy-logs
make_att_dir /tmp/deploy

#
# Enable localhost ssh login to work around
# https://github.com/ansible/ansible/issues/9383
#
mkdir -p ~ansible/.ssh
chown ansible:ansible ~ansible/.ssh
chmod 750 ~ansible/.ssh
ssh-keygen -q -f ~/.ssh/id_rsa -t rsa -N ""
cat ~/.ssh/id_rsa.pub > ~ansible/.ssh/authorized_keys
chmod og-wx ~ansible/.ssh/authorized_keys
ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
/sbin/sshd

#
# "Pre-deploy" base ansible-scripts
#
test_home="/home/ansible/ansible_scripts"
mkdir -p "${test_home}"
git archive --format=tar "${sha1}" | (cd "${test_home}" && tar xf -)
chown ansible:ansible -R "${test_home}"

#
# Pack new ansible artefact
#
git archive --format=tar.gz --prefix=ansible/ -o ansible-new.tar.gz "${sha1}"

#
# Use base ansible-scripts to deploy new artefact
#
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
export ANSIBLE_CONFIG="${test_home}"/ansible.cfg
sed -i '/^remote_tmp.*/d' "${ANSIBLE_CONFIG}" # use default remote_tmp
                                              # as /tmp breaks for some reason

deploy() {
    # use default remote_tmp as /tmp breaks for some reason
    sed -i '/^remote_tmp.*/d' "${ANSIBLE_CONFIG}"
    ansible-playbook "${test_home}"/site.yml -vv \
      --user ansible \
      --tags ansible \
      -e "@${WORKSPACE}/$(dirname "$0")/stubvars.yml" \
      -i "${WORKSPACE}/$(dirname "$0")/inventory"
}

# Deploy new ansible
deploy
