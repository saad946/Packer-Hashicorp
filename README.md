# packer-crash-course

#Installations:
https://developer.hashicorp.com/packer/downloads?product_intent=packer

# Commands
To install packer (linux)
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
packer --version

To init:
packer init <packer template file>
e.g. packer init main.pkr.hcl

To validate packer template:
packer validate <packer template file>
e.g. packer validate main.pkr.hcl

to start image build:
packer build <packer template file>
e.g. packer build main.pkr.hcl

to pass aws vartiaable as params:
packer -var "aws_access_key=$AWS_ACCESS_KEY" -var "aws_secret_key=$AWS_SECRET_KEY"
