FROM sbeliakou/centos:7.2

RUN yum install -y python-devel \
                   python-pip \
                   gcc \
                   openssl-devel \
                   git \
                   file \
                   openssh-server \
                   openssh-clients && \
    pip install ansible==2.2.1 && \
    pip install -U ansible-lint && \
    ansible --version && \
    ansible-lint --version

WORKDIR /workspace
