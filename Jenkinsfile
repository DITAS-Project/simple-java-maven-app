pipeline {
    // Mandatory to use per-stage agents
    agent none
    stages {        
        stage('Image deploy') {
            // TO-DO avoid downloading the source from git again, not neccessary
            agent any
            steps {
                echo 'to-do'
                // Staging environment: 31.171.247.162
                // Private key for ssh: /opt/keypairs/ditas-testbed-keypair.pem
                // Call the deployment script
                sh './jenkins/scripts/deploy-staging.sh'
            }
        }
    }
}
