# Arquivo de configuração do Makefile

#Definição de variáveis
ContainerNameMysql = server-mysql-8.0
ContainerNamePhpMyAdmin = server-phpmyadmin

# Comandos

up:
	docker-compose up -d
	docker cp ./scripts $(ContainerNameMysql):/
	docker exec -it $(ContainerNameMysql) bash -c "chmod +x /scripts/start.sh"
	docker exec -it $(ContainerNameMysql) bash -c "chmod +x /scripts/createBackupBancos.sh"
	docker exec -it $(ContainerNameMysql) bash -c "/scripts/start.sh"
	docker exec -it $(ContainerNameMysql) bash -c "/scripts/createBackupBancos.sh"

down:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f 

ps:
	docker-compose ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
	
# Este Comando é utilizado para criar uma imagem a partir de um container
commit:
	docker commit $(ContainerNameMysql) $(ContainerNameMysql)
	docker commit $(ContainerNamePhpMyAdmin) $(ContainerNamePhpMyAdmin)

# Este comando é utilizado para criar um container a partir de uma imagem
run:
	docker run -d --name $(ContainerNameMysql) $(ContainerNameMysql)
	docker run -d --name $(ContainerNamePhpMyAdmin) $(ContainerNamePhpMyAdmin)

bash:
	docker exec -it $(ContainerNameMysql) bash

bash-phpmyadmin:
	docker exec -it $(ContainerNamePhpMyAdmin) bash