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

docker pause?