#!/bin/bash

# Esperar até que o MySQL esteja pronto
echo "Esperando o MySQL iniciar..."
until mysqladmin ping -h "localhost" --silent; do
    echo "MySQL não está pronto. Aguardando..."
    sleep 3
done

# Cor verde para sucesso
echo -e "\033[32mMySQL iniciado com sucesso!\033[0m"

# Verificar se há arquivos .sql no diretório /scripts
sql_files=$(find /scripts/ -type f -name "*.sql")

if [ -z "$sql_files" ]; then
    echo "Nenhum arquivo .sql encontrado no diretório /scripts \n"
else
    
    # Exibir os arquivos .sql encontrados
    echo "Arquivos .sql encontrados:"
    echo "$sql_files"

    # Executar todos os arquivos .sql no diretório /scripts como root
    for sql_file in /scripts/*.sql; do
        echo "Executando $sql_file..."
        mysql -u root -p  < "$sql_file"
    done

    # Cor verde para sucesso ao final
    echo -e "\033[32mTodos os arquivos SQL foram executados com sucesso!\033[0m"
    
fi
