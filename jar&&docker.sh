
PURPLE='\033[0;35m'
NC='\033[0m'
VERSAO=17


installDockerAndMySQL() {
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá Cliente, te ajudarei no processo para instalar o Docker e criar o Container com o MySQL 5.7"
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos verificar primeiramente se você possui o Docker instalado..."
    sleep 2
    docker -v
    if [ $? -eq 0 ]; then
        echo ": O senhor(a) já tem o Docker instalado!!!"
    else
        echo "Não identificamos nenhuma versão do Docker instalado, porém sem problemas, irei resolver isso agora mesmo!"
        echo "Confirme para nosso sistema se realmente deseja instalar o Docker (S/N)?"
        read inst
        if [ "$inst" == "S" ]; then
            echo "Ok! Você escolheu instalar o Docker ;D"
            echo "Adicionando o repositório!"
            sleep 2
            sudo apt update -y
            clear
            echo "Atualizando! Quase lá."
            sleep 2
            sudo apt install docker.io -y
            sudo systemctl start docker
            sudo systemctl enable docker
            sleep 2
            sudo docker pull mysql:5.7
            sudo docker run -d -p 3306:3306 --name MagisterNowl -e "MYSQL_DATABASE=magister" -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
            sudo docker exec -i MagisterNowl sudo mysql magister bash
            echo "Docker instalado com sucesso e container criado com sucesso!"
            sudo mysql 
            sleep 2
            echo "Agora iremos criar as tabelas no banco de dados"
            sleep 2 
            sudo apt install mysql-server
            sudo mysql
             CREATE USER 'aluno'@'localhost' IDENTIFIED BY 'aluno';
              GRANT ALL PRIVILEGES ON * . * TO 'aluno'@'localhost';
              exit
              mysql -u aluno -p aluno < script.sql;
            exit
            echo "Tabelas criadas com sucesso!"
            echo "Tudo configurado com sucesso!"
        else
            echo "Você optou por não instalar o Docker por enquanto."
        fi
    fi
}

installJavaAndRunApplication() {
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Olá usuário, serei seu assistente para instalação do Java!"
    echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Verificando se você possui o Java instalado na sua máquina!"
    sleep 2
    # Verifica se o Java está instalado
    java -version
    if [ $? -eq 0 ]; then

        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você já possui o Java instalado na sua máquina!"
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
        sudo apt update && sudo apt upgrade -y
        clear
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Pacotes atualizados!"
        # Navega até o diretório Desktop
        cd /home/$USER/Desktop
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Diretório Desktop acessado!"
        sleep 2
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos baixar nosso arquivo JAR..."
        # Baixa o arquivo JAR
       wget https://github.com/SPTECH-Nowl/SistemaWill/src/main/java/target/sistema-will-1.0-jar-with-dependencies.jar
        sleep 2
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Já temos o arquivo! Vamos executá-lo."
        sleep 2
        # Executa o arquivo JAR
              cd SistemaWill/src/main/java/target
              java -jar sistema-will-1.0-jar-with-dependencies.jar
    else
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Não foi encontrada nenhuma versão do Java na sua máquina, mas iremos resolver isso!"
        echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você deseja instalar o Java na sua máquina (S/N)?"
        read inst
        if [ "$inst" == "S" ]; then
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Ok! Você decidiu instalar o Java na máquina, uhul!"
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Adicionando o repositório!"
            sleep 2
            sudo add-apt-repository ppa:linuxuprising/java
            clear
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Atualizando os pacotes... Quase acabando."
            sleep 2
            sudo apt update -y
            clear
            if [ $VERSAO -eq 17 ]; then
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Preparando para instalar a versão 17 do Java. Lembre-se de confirmar a instalação quando necessário!"
                sudo apt-get install openjdk-17-jdk
                clear
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Java instalado com sucesso!"
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Vamos atualizar os pacotes..."
                sudo apt update && sudo apt upgrade -y
                clear
                # Navega até o diretório Desktop
                cd /home/$USER/Desktop
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Diretório Desktop acessado!"
                sleep 2
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Agora iremos baixar nosso arquivo JAR..."
                # Baixa o arquivo JAR
                wget https://github.com/SPTECH-Nowl/SistemaWill/src/main/java/target/sistema-will-1.0-jar-with-dependencies.jar 
                sleep 2
                echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Já temos o arquivo! Vamos executá-lo."
                sleep 2
                # Executa o arquivo JAR
                cd SistemaWill/src/main/java/target
              java -jar sistema-will-1.0-jar-with-dependencies.jar
    
            fi
        else
            echo -e "${PURPLE}[SPTECH-Nowl]:${NC} Você optou por não instalar o Java por enquanto, até a próxima então!"
        fi
    fi
}


