pipeline {
    agent { dockerfile true }
    /*agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
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
		echo 'Generate docker image with the src folder'
	    	// This will search for a Dockerfile in the working directory and build the image to the local repository
		sh 'docker build .'
	    }
	}
    }
}
