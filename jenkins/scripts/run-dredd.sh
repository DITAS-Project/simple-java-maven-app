#!/usr/bin/env bash
# Staging environment: 31.171.247.162
# Private key for ssh: /opt/keypairs/ditas-testbed-keypair.pem 

scp -i /opt/keypairs/ditas-testbed-keypair.pem Dockerfile.artifact cloudsigma@31.171.247.162:/home/cloudsigma/dreddtest/Dockerfile.artifact

# ssh -i /opt/keypairs/ditas-testbed-keypair.pem cloudsigma@31.171.247.162 << 'ENDSSH'

# Create the symbolic link in order to use 'node' as PATH variable
# sudo ln -s /home/cloudsigma/.nvm/versions/node/v8.11.1/bin/node /usr/bin/node

# Run dredd from the real path
#  /home/cloudsigma/.nvm/versions/node/v8.11.1/bin/dredd /home/cloudsigma/dreddtest/apimattia.yaml http://31.171.247.162:50003

ENDSSH
