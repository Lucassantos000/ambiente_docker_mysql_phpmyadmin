#!/bin/bash

# Esperar até que o MySQL esteja pronto
until mysqladmin ping -h"localhost" --silent; do
    echo "MySQL não está pronto. Aguardando..."
    sleep 3
done

echo -e "\033[32mMySQL iniciado com sucesso!\033[0m"


# Verificar se o diretório /backups existe
if [ ! -d "/backups" ]; then
    mkdir /backups
    # Aplicar a cor verde em "Ok"
    echo "Diretório /backups criado com sucesso"
    echo -e "\033[32mOk\033[0m"
fi

# Verificar a permissão de escrita no diretório /backups
if [ ! -w "/backups" ]; then
    # Dar permissão de escrita
    chmod +w /backups
    # Aplicar a cor verde em "Ok"
    echo "Permissão de escrita concedida ao diretório /backups"
    echo -e "\033[32mOk\033[0m"
fi


# Data atual no formato y-m-d-H-M-S
data=$(date +%Y-%m-%d-%H-%M-%S)

# Criar um backup do banco de dados
#mysqldump -u root -p"$senha" --all-databases > /backups/bancos-$data.sql
mysqldump --version
mysqldump -u root -p  --all-databases --routines --triggers --events --flush-logs --single-transaction --add-drop-database --add-drop-table --add-drop-trigger > /backups/bancos-$data.sql




# Simular uma barra de progresso para a compactação usando 'pv'
# Certifique-se de que o 'pv' esteja instalado no seu sistema (sudo apt-get install pv)
echo "Compactando o backup..."
tar -zcvf /backups/bancos-$data.tar.gz /backups/bancos-$data.sql

# Remover o arquivo .sql após a compactação
rm /backups/bancos-$data.sql

# Remover backups com mais de 7 dias
echo "Removendo backups antigos..."
find /backups -ctime +7 -name "*.tar.gz" -exec rm -f {} \;

# Registrar no log a criação do backup
echo "Backup criado em /backups/bancos-$data.tar.gz" >> /backups/backup.log

# Registrar no log a remoção de backups antigos
echo "Backups antigos removidos em $(date)" >> /backups/backup.log

# Finalização
echo -e "\033[32mProcesso de backup concluído com sucesso!\033[0m"
