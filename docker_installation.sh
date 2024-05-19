#!/bin/bash

# Update package list and upgrade all packages
echo "Updating package list..."
sudo apt update -y

# Create Docker networks
echo "Creating Docker networks..."
sudo docker network create public_network
sudo docker network create private_network

# Upgrade all packages
echo "Upgrading packages..."
sudo apt upgrade -y

# Install required packages for Docker
echo "Installing required packages..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's official repository
echo "Adding Docker's official repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
echo "Updating package list again..."
sudo apt update

# Install Docker
echo "Installing Docker..."
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Start and enable Docker
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Download Docker Compose
echo "Downloading Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Set executable permissions for Docker Compose
echo "Setting executable permissions for Docker Compose..."
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
ls -l /usr/local/bin/docker-compose
docker-compose --version

echo "Setup complete."

