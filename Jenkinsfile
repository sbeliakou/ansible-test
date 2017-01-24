node {
   echo 'Hello World'
   setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'status started', state: 'PENDING'
   sleep 5
   setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'status ok', state: 'SUCCESS'
}
