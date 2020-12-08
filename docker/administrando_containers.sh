#Para instalar a versão conforme a distro
curl -fsSL http://get.docker.com | bash

#Doc. oficial:
#https://docs.docker.com/engine/install/centos/

#Habilitar para os demais usuarios utilizarem o cli
sudo usermod -aG docker your-user

#Version
docker version

#Listar containers(Sintaxe antiga: docker ps, docker ps -a)
docker container ls -a

#Executar(Sintaxe antiga: docker run)
docker container run -ti hello-world

#Sair do container fazendo com que o comando de entrypoint continue, exemplo bash da imagem do ubuntu:
#CTRL+p+q

#Criar um container com a latest image do Ubuntu:
docker run -ti ubuntu
#-ti = Terminal, interactive

#Se der um ps -ef pode-se verificar que o processo de entry point:
ps -ef
#root@353e79559ed1:/# ps -ef     
#UID          PID    PPID  C STIME TTY          TIME CMD
#root           1       0  0 10:02 pts/0    00:00:00 /bin/bash
#root          13       1  0 10:05 pts/0    00:00:00 ps -ef

#Para conectar em um container em exec:
docker container attach ID/Nome

#nginx
docker container run -ti nginx

#O processo dentro container precisa estar rodando como foreground, e nao como daemon.

#Rodando o container como daemon:
docker container run -d nginx

#Para executar um comando no container:
docker container exec -ti 883843f3c0d6 ls /

docker container exec -ti 883843f3c0d6 ls /usr/share/nginx
#html

docker container exec -ti 883843f3c0d6 bash

#Para o container:
docker container stop ID/Nome

#Starta o container:
docker container start ID/Nome

#Restart:
docker container restart ID/Nome

#Verificar detalhes da imagem:
docker container inspect ID/Nome

#Pausar a exec. do container:
docker pause ID/Nome

#Despausar a exec. do container:
docker container unpause ID/Nome

#[root@localhost ~]# docker container exec -it 883843f3c0d6 bash
#root@883843f3c0d6:/# echo "Don't Panic" > /usr/share/nginx/html/index.html 
#root@883843f3c0d6:/# exit
#exit
#[root@localhost ~]# curl 172.17.0.3
#Don't Panic
#[root@localhost ~]# docker container pause 883843f3c0d6
#883843f3c0d6
#[root@localhost ~]# curl 172.17.0.3
#[root@localhost ~]# docker container unpause 883843f3c0d6
#883843f3c0d6
#[root@localhost ~]# curl 172.17.0.3
#Don't Panic
#[root@localhost ~]# 

#Verificar log do container:
docker container logs -f ID/Nome

#Remover container:
docker rm ID/Nome

#Forcar remocao do container:
docker rm -f ID/Nome

#Remover container, primeros 3 caracteries sao suficientes:
docker container rm 8c7