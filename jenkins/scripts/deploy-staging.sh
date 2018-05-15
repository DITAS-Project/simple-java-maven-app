#!/usr/bin/env bash
# Staging environment: 31.171.247.162
# Private key for ssh: /opt/keypairs/ditas-testbed-keypair.pem 

# TODO state management? We are killing without careing about any operation the conainer could be doing.


ssh -i /opt/keypairs/ditas-testbed-keypair.pem cloudsigma@31.171.247.162 << 'ENDSSH'
# Ensure that a previously running instance is stopped (-f stops and removes in a single step)
# || true - "docker stop" failt with exit status 1 if image doen't exists, what makes the Pipeline fail. the "|| true" forces the command to exit with 0.
echo "heytuu"

ln -s /home/cloudsigma/.nvm/versions/node/v8.11.1/bin/node /usr/bin/node
/home/cloudsigma/.nvm/versions/node/v8.11.1/bin/dredd /home/cloudsigma/dreddtest/apimattia.yaml http://31.171.247.162:50003
# sudo docker rm -f simple-java-maven-app || true
# sudo docker pull ditas/simple-java-maven-app:latest
# sudo docker run -d --name simple-java-maven-app ditas/simple-java-maven-app:latest
ENDSSH
