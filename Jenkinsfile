node("host-node") {
   def checks = [
      {
         checkout(
           [$class: 'GitSCM', branches: [[name: "${env.GITHUB_PR_HEAD_SHA}"]], userRemoteConfigs: [[url: 'https://github.com/sbeliakou/ansible-test/']]]
         )
         setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check started', state: 'PENDING'
         ansiColor('xterm') {
            try {
               sh "docker run --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} sbeliakou/ansible:2.2.1-1 ansible-playbook --syntax-check playbook.yml -c local -i localhost,"
               setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check completed successfully', state: 'SUCCESS'      
            } 
            catch (err){
               setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check Failed', state: 'FAILURE'
            }
         }
      },
      {
         checkout(
           [$class: 'GitSCM', branches: [[name: "${env.GITHUB_PR_HEAD_SHA}"]], userRemoteConfigs: [[url: 'https://github.com/sbeliakou/ansible-test/']]]
         )
         setGitHubPullRequestStatus context: 'Ansible Dry-Run Check', message: 'Dry-Run Check started', state: 'PENDING'
         ansiColor('xterm') {
            try {
               sh "docker run --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} sbeliakou/ansible:2.2.1-1 ansible-playbook --check playbook.yml -c local -i localhost,"
               setGitHubPullRequestStatus context: 'Ansible Dry-Run Check', message: 'Dry-Run Check completed successfully', state: 'SUCCESS'      
            } 
            catch (err){
               setGitHubPullRequestStatus context: 'Ansible Dry-Run Check', message: 'Dry-Run Check Failed', state: 'FAILURE'
            }
         }
      }
   ]
   
   stage("Ansible Checks"){
      parallel checks
   }
}
