checkName = "Ansible Deploy Check"
test = "docker run --rm -v ${WORKSPACE}:${WORKSPACE} -e ${WORKSPACE}=${WORKSPACE} -e sha1=${sha1} -w ${WORKSPACE}  ${ansible_container} tests/deploy.sh"

setGitHubPullRequestStatus context: "${checkName}", 
    message: "${checkName} started", 
    state: 'PENDING'
try {
    sh "${test}"

    setGitHubPullRequestStatus context: "${checkName}", 
        message: "${checkName} completed successfully", 
        state: 'SUCCESS'
} catch (err){
    setGitHubPullRequestStatus context: "${checkName}", 
        message: "${checkName} Failed", 
        state: 'FAILURE'
}