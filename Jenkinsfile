def ansible_container = "sbeliakou/ansible:2.2.1-1"
def ansible = "docker run --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} ${ansible_container} ansible-playbook -c local -i localhost,"

node("host-node") {
   // checkout(
   //    [$class: 'GitSCM', branches: [[name: "${env.GITHUB_PR_HEAD_SHA}"]], userRemoteConfigs: [[url: 'https://github.com/sbeliakou/ansible-test/']]]
   // )

   checkout scm

   ansiColor('xterm') {
      parallel step1:{
         stage("Ansible Syntax Check"){
            setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check started', state: 'PENDING'
            try {
               sh "${ansible} --syntax-check playbook.yml"
               setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check completed successfully', state: 'SUCCESS'
            } catch (err){
               setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check Failed', state: 'FAILURE'
            }
         }
      },
      step2: {
         stage("Ansible Dry-Run Check"){
            setGitHubPullRequestStatus context: 'Ansible Dry-Run Check', message: 'Dry-Run Check started', state: 'PENDING'
            try {
               sh "ansible --check playbook.yml"
               setGitHubPullRequestStatus context: 'Ansible Dry-Run Check', message: 'Dry-Run Check completed successfully', state: 'SUCCESS'
            } catch (err){
               setGitHubPullRequestStatus context: 'Ansible Dry-Run Check', message: 'Dry-Run Check Failed', state: 'FAILURE'
            }
         }
      }
   }
}
