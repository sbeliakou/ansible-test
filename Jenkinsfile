node("host-node") {
   stage("Syntax Check"){
      setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check started', state: 'PENDING'
      ansiColor('xterm') {
         try {
            sh "docker run --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} sbeliakou/ansible:2.2.1-1 ansible-playbook --syntax-check playbook.yml -c local -i localhost,"
         } catch {
            setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check Failed', state: 'Failure'
         }
      }
      setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'Syntax Check completed successfully', state: 'SUCCESS'      
   }
}
