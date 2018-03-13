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
                    //TODO no me va la cache con ~, habrá que poner una variable de entorno del workspace
                    args '-v "$HOME/.m2":/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
                archiveArtifacts 'target/*.jar'
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Image creation') {
            agent any
            steps {
                // TODO tengo que pasar el JAR que se ha creado en el build andetro de esta img. No puedo crearlo de nuevo porque estoy con agent any. Pero puedo buldearlo de nuevo en el propio Dockerfile.artifact como comando!
                echo 'Creating the image...'
                // This will search for a Dockerfile.artifact in the working directory and build the image to the local repository 
                sh "docker build -t \"aitorf/simple-java-maven-app:${env.BUILD_ID}\" -f Dockerfile.artifact ."
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
            }
        }
    }
}
