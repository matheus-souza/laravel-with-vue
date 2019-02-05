#!/bin/bash

echo "---- Iniciando instalacao do ambiente de Desenvolvimento PHP ---"

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Removendo versões antigas do docker ---"
sudo apt-get remove docker docker-engine docker.io containerd runc -y

echo "--- Instalando dependencias para o docker ---"
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

echo "--- Adicionando chave GPG oficial Docker ---"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "--- Adciionando repositório oficial ---"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Instalando Docker CE ---"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo "--- Instalando docker-compose ---"
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "--- Ajustando permissões para execução ---"
sudo addgroup --system docker
sudo adduser vagrant docker
newgrp docker
sudo service docker restart

chmod +x /nameless/run

echo "--- Criando arquivos de configuração de ambiente ---"
cp /nameless/.env.laradock.dev /nameless/laradock/.env
cp /nameless/.env.dev /nameless/.env

echo "--- Rodando ambiente Laradock ---"
cd /nameless/laradock
docker-compose up -d nginx postgres


echo "[OK] --- Ambiente de desenvolvimento concluido ---"