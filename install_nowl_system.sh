#!/bin/sh

sudo apt update && sudo apt upgrade
# Instalação do Docker
sudo apt-get update
sudo apt-get install docker.io -y

# Iniciar o serviço do Docker
systemctl start docker
systemctl enable docker

# Verificar se o container MySQL já existe
if ! docker ps -a --format '{{.Names}}' | grep -q "magister"; then
    # Criar e executar o container MySQL
   sudo docker run -d --name magister -e MYSQL_ROOT_PASSWORD=aluno -p 3306:3306 mysql:latest

    # Aguardar alguns segundos para o container ser criado e iniciado
    sleep 10

    # Copiar o script SQL para dentro do container
    sudo docker cp /home/ubuntu/Assistentes-app/script.sql magister:/script.sql

    # Executar o script SQL dentro do container
    sudo docker exec -i magister mysql -u root -paluno < /script.sql
    show_message "Tabelas criadas com sucesso!"
else
    show_message "O container MySQL já existe. Ignorando a criação de tabelas."
fi

show_message "Agora iremos verificar se você já possui o Java instalado, aguarde um instante..."
sleep 5

if ! command -v java &> /dev/null; then
    show_message "Você ainda não possui o Java instalado."
    echo "Confirme se deseja instalar o Java (S/N)?"
    read inst
    if [ "$inst" == "S" ]; then
        show_message "Ok! Você escolheu instalar o Java."
        show_message "Adicionando o repositório..."
        sleep 7
        sudo add-apt-repository ppa:linuxuprising/java -y
        clear
        show_message "Atualizando os pacotes... Quase acabando."
        sleep 7
        sudo apt update -y

        # Instalação do Java
        if [ $VERSAO -eq 17 ]; then
            show_message "Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
            sudo apt-get install openjdk-17-jdk -y
            clear
            show_message "Java instalado com sucesso!"
            show_message "Vamos atualizar os pacotes..."
            sudo apt update && sudo apt upgrade -y
        fi
    else
        show_message "Você optou por não instalar o Java no momento."
    fi
else
    show_message "Você já possui o Java instalado!"
fi

# Navegar para o diretório Desktop (ajuste o caminho conforme necessário)
cd ~/Desktop
show_message "Diretório Desktop acessado!"

# Verificar se o arquivo JAR já existe
if [ ! -f "sistema-nowl-1.0-jar-with-dependencies.jar" ]; then
    show_message "Baixando o arquivo JAR..."
    # Instale o wget se não estiver instalado
    sudo apt install wget -y
    # Baixar o arquivo JAR
    wget https://github.com/SPTECH-Nowl/SistemaJava/raw/main/src/main/java/target/sistema-nowl-1.0-jar-with-dependencies.jar
    show_message "Arquivo JAR baixado com sucesso!"
else
    show_message "O arquivo JAR já existe. Ignorando o download."
fi

show_message "Executando o arquivo JAR..."
# Executar o arquivo JAR
java -jar sistema-nowl-1.0-jar-with-dependencies.jar
chmod +x sistema-nowl-1.0-jar-with-dependencies.jar

show_message "Tudo configurado com sucesso, até a próxima!"
