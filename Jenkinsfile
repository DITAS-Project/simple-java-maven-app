pipeline {
  agent any
  stages {
    stage ('Notification e-mail') {
      steps {
	  	echo 'Sending notification email'
        emailext (
            subject: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
            body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
              <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
            recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
      }
    }
  }
}
/*
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
                    args '-v "$HOME/.m2":/root/.m2'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
                // Lets make the JAR available from the artifacts tab in Jenkins
                archiveArtifacts 'target/*.jar'

                // Run the tests (we don't use a different stage for improving the performance, another stage would mean another agent)
                sh 'mvn test'
            }
            // TODO stop if test fails!
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
                sh "docker build -t \"ditas/simple-java-maven-app:latest\" -f Dockerfile.artifact ."
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
                echo "Pushing the image ditas/simple-java-maven-app:latest..."
                sh "docker push ditas/simple-java-maven-app:latest"
                echo "Done"
            }
        }
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
*/
