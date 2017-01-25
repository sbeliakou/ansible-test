checkName = "Ansible Syntax Check"
ansible = "docker run --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} ${ansible_container} ansible-playbook -c local -i localhost,"

setGitHubPullRequestStatus context: "${checkName}", 
    message: "${checkName} started", 
    state: 'PENDING'
try {
    sh "${ansible} --syntax-check playbook.yml"

    setGitHubPullRequestStatus context: "${checkName}", 
        message: "${checkName} completed successfully", 
        state: 'SUCCESS'
} catch (err){
    setGitHubPullRequestStatus context: "${checkName}", 
        message: "${checkName} Failed", 
        state: 'FAILURE'
}