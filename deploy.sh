#!/bin/bash

# Instalar o Docker
echo "Instalando o Docker..."
sudo apt-get update
sudo apt-get install -y docker.io
echo "Docker instalado com sucesso!"

# Iniciar o serviço do Docker
echo "Iniciando o serviço do Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Instalar o kubectl
echo "Instalando o kubectl..."
sudo apt-get update
sudo apt-get install -y apt-transport-https gnupg
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
sudo apt-get update
sudo apt-get install -y kubectl
echo "kubectl instalado com sucesso!"

# Aguardar alguns segundos para garantir que o Kubernetes esteja pronto
sleep 15

# Aplicar os manifestos Kubernetes antes de executar Docker e Java
echo "Aplicando manifestos Kubernetes..."
kubectl apply -f mysql-deployment.yaml
kubectl apply -f java-deployment.yaml

# Aguardar a implantação completa (pode variar dependendo do ambiente)
echo "Aguardando a implantação completa..."
sleep 30

# Exibir informações sobre os serviços e pods antes de executar Docker e Java
echo "Informações sobre serviços (antes):"
kubectl get services

echo "Informações sobre pods (antes):"
kubectl get pods

# Executar o script Docker
echo "Executando o script Docker..."
chmod +x ./docker.sh
./docker.sh

# Aguardar alguns segundos para garantir que o MySQL esteja pronto
sleep 15

# Executar o script Java
echo "Executando o script Java..."
chmod +x ./java.sh
./java.sh

# Aguardar mais alguns segundos para garantir que o Java esteja pronto

# Exibir informações sobre os serviços e pods após a execução de Docker e Java
echo "Informações sobre serviços (depois):"
kubectl get services

echo "Informações sobre pods (depois):"
kubectl get pods