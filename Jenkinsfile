pipeline
{
   agent {
      dockerfile {
          filename 'Dockerfile'
          args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
       }
   }
    /*agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2 -v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }*/
    stages {
        stage('Build') {
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
        }
        stage('Deploy') { 
           steps {          
              echo 'Execute a docker cmd to check reachability of docker binary '
              // This will search for a Dockerfile in the working directory and build the image to the local repository
              sh 'echo $UID'
              sh 'docker ps'
           }
       }
    }
}
