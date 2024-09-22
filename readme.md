## Container com mysql e phpmyadin 

>  Container será usado nas aplicações que usando base de dados mariadb-mysql e aplicação phpmyadmin para gerenciar o estado da base de dados pelo browser


---

1. Crie a rede dockernet

```bash
docker network create --subnet=10.0.0.0/8 dockernet
```

2. Copie o arquivo **env-axample** alterando o nome para **.env**
```bash
cp .env-example .env
```

3. Configure as veriávei de ambiente no arquivo .env conforme sua necessidade

4. Inicie os containers:
```bash
make up
```

**Autor:** Lucas dos Santos Marques  
**Data:** 15-06-2024


