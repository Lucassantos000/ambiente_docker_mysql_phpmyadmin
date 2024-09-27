#!/bin/bash

# Solicita a senha
echo -n "Enter MySQL root password: "
read -s MYSQL_PASSWORD
echo

# Lista todos os bancos de dados que começam com ACAI_
databases=$(mysql -u root -p"$MYSQL_PASSWORD" -e "SHOW DATABASES LIKE 'ACAI%';" | grep ACAI)

# Itera sobre cada banco de dados e deleta
for db in $databases; do
  # Ignora o cabeçalho 'Database'
  if [ "$db" != "Database" ]; then
    mysql -u root -p"$MYSQL_PASSWORD" -e "DROP DATABASE $db;"
  fi
done
