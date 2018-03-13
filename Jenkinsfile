pipeline {
    // Mandatory to use per-stage agents
    agent none
    stages {
        stage('Build - test') {
        // Ya no necesito todo esto no? Puedo usar una imagen estandar.
            agent {
                docker {
                    image 'maven:3.5.3-jdk-8'
                    // TODO esta caché debería ser por workspace, no por usuario, dos builds maven compartirían cache aquí!
                    //args '-u 0 -v ~/.m2:~/.m2 -v /var/run/docker.sock:/var/run/docker.sock' 
                    // TODO cache is not working because /root is not writable by cloudsigma (1000) user that jenkins is using to connecto to the container
                    // -u 0 works but arises other problems like asigning 
                    args '-v "$HOME/.m2":/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
                // Lets make the JAR available from the artifacts tab in Jenkins
                archiveArtifacts 'target/*.jar'
                
                // Run the tests (we don't use a different stage for improving the performance, another stage would mean another agent)
                sh 'mvn test'
            }
            post {
                always {
                    // Record the jUnit test
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Image creation') {
            agent any
            steps {
                // The Dockerfile.artifact copies the code into the image and run the jar generation. 
                echo 'Creating the image...'
                // This will search for a Dockerfile.artifact in the working directory and build the image to the local repository 
                sh "docker build -t \"ditas/simple-java-maven-app:${env.BUILD_ID}\" -f Dockerfile.artifact ."
                echo "Done"
                echo 'Retrieving Docker Hub password from /opt/ditas-docker-hub.passwd...'
                // Get the password from a file. This reads the file from the host, not the container. Slaves already have the password in there.
                script {
                    password = readFile '/opt/ditas-docker-hub.passwd'
                }
                echo "Done"
                echo 'Login to Docker Hub as ditasgeneric...'
                sh "docker login -u ditasgeneric -p ${password}"
                echo "Done"
                echo "Pushing the image ditas/simple-java-maven-app:${env.BUILD_ID}..."
                sh "docker push ditas/simple-java-maven-app:${env.BUILD_ID}"
                echo "Done"
            }
        }
        stage('Image deploy') {
            steps {
                echo 'to-do'
                // Staging environment: 31.171.247.162
                // Private key for ssh: /opt/keypairs/ditas-testbed-keypair.pem
                sh 'ssh -i /opt/keypairs/ditas-testbed-keypair.pem cloudsigma@31.171.247.162 sudo docker ps'
            }
        }
    }
}
