### this is to prepare a custom image ami with gitae running on port 8080

## run an ec2 instance then install docker, run gitea with docker-compose

# on running instance which to be use as an ami to build new ec2
# update OS
sudo apt-get update
sudo apt-get upgrade -y

## install docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## create docker-compose.yml as file "docker-compose.yml"
copy/make file in vm
docker-compose.yml

# create a directory gitea to be mounted as gitea /data
mkdir gitea

## run docker image
sudo docker compose up -d

# on AWS console capture this instance as AMI/custom image



