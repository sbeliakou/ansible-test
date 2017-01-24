node {
   echo 'Hello World'
   setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'status started', state: 'PENDING'
   sleep 10
   setGitHubPullRequestStatus context: 'Ansible Syntax Check', message: 'status ok', state: 'SUCCESS'
   // githubNotify account: 'sbeliakou', context: 'Context', credentialsId: 'jenkins-selfserve-1', description: 'Description', gitApiUrl: '', repo: 'https://github.com/sbeliakou/ansible-test', sha: '${GITHUB_PR_HEAD_SHA}', status: 'SUCCESS', targetUrl: ''
}
