pipeline
{
   agent {
      dockerfile {
          filename 'Dockerfile.build'
          args '-u 0 -v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v /opt:/opt'
       }
   }
    /*agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2 -v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }*/
    stages {
        /*stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }*/
        stage('Image creation') { 
           steps {          
              echo 'Creating the image...'
              // This will search for a Dockerfile.artifact in the working directory and build the image to the local repository
              sh "docker build -t \"aitorf/simple-java-maven-app:${env.BUILD_ID}\" -f Dockerfile.artifact ."
              echo "Done"
              echo 'Retrieving Docker Hub password from /opt/aitorf-docker-hub.passwd...'
              // Get the Docker Hub password from a shared volume. Slaves already have the password in there.
              // TODO - Hacer que los dos excalvos la tengan, ahora solo la tiene el 1
              //sh "docker login -u aitorf -p \$(< /opt/aitorf-docker-hub.passwd)"
              script { 
                  password = readFile '/opt/aitorf-docker-hub.passwd'
              }
              echo "Done"
              echo 'Login to Docker Hub as aitorf...'
              //sh "docker login -u aitorf -p ${password}"
              sh "docker login -u aitorf -p " + ${password}
              echo "Done"
              echo "Pushing the image aitorf/simple-java-maven-app:${env.BUILD_ID}..."
              sh "docker push aitorf/simple-java-maven-app:${env.BUILD_ID}"
              echo "Done"
           }
       }
    }
}
