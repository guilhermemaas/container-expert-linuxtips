#Criar os nodes das ilhas faltantes:
docker-machine create --driver virtualbox isla-matanceros
docker-machine create --driver virtualbox isla-tacano
docker-machine create --driver virtualbox isla-pena

#Conectando nos nodes das novas ilhas:
docker-machine ssh isla-matanceros

#Iniciando o cluster na Ilha Nublar:
docker swarm init

#Rodar o comando para ingressar os nodes no token, via ssh:
docker swarm join --token SWMTKN-1-3jghrxnxoz8wshg2p5zpdocoyxu67ml8exhn5u4soooia7bxt6-11yt7va08bdwzmjnrx42sxebq 192.168.0.110:2377

#Verificar os nodes pertencentes ao cluster:
docker node ls

#Promover a Ilha Sorna como manager secundário:
docker node promote isla-sorna 

#Criar uma rede para as ilhas da Ingen Corp:
docker netowrk create islas-ingen

#

