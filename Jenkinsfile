pipeline {
    agent {
        dockerfile {
            // This file must be in the root of the repo 
            filename 'Dockerfile.build'
            // -v ...  > bind mount the docker socker from the host to allow the container where we are building, to create docker images
            // -u 0    > to run the container as root. Otherwise the normal user can't access the Docker socker
            // TO-DO add a cache volume for NPM?
            //args '-u 0 -v /var/run/docker.sock:/var/run/docker.sock'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('Build') {
            steps {
                echo "Building!"
                sh 'npm install --prefix src'
                echo "Done"
            }
        }
        stage('Image creation') {
            steps {
                echo 'Creating the image...'
                // This will search for a Dockerfile in the src folder and will build the image to the local repository
                // Using latest tag to override tha newest image in the hub
                sh "cd src; docker build -t \"ditas/data-utility-refinement:latest\" ."
                echo "Done"
            }
        }
        stage('Push image') {
            steps {
                echo 'Retrieving Docker Hub password from /opt/ditas-docker-hub.passwd...'
                // Get the password from a file. This reads the file from the host, not the container. Slaves already have the password in there.
                script {
                    password = readFile '/opt/ditas-docker-hub.passwd'
                }
                echo "Done"
                // Login to DockerHub with the ditas generic Docker Hub user
                sh "docker login -u ditasgeneric -p ${password}"
                echo 'Login to Docker Hub as ditasgeneric...'
                sh "docker login -u ditasgeneric -p ${password}"
                echo "Done"
                echo "Pushing the image ditas/data-utility-refinement:latest..."
                // Push the image to DockerHub
                sh "docker push ditas/data-utility-refinement:latest"
                echo "Done"
            }
        }
        stage('Deployment ') {
            steps {
                echo 'TO-DO'
            }
        }
    }
    post {
        always {
            echo 'Post action fired'
        }

    }
}
