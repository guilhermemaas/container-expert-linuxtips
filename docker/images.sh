docker image build -t meu_apache:1.0.0 .

docker image list
#REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
#meu_apache          1.0.0               9f0e6f703405        44 seconds ago      250MB

dpkg -l | grep apache #Verificar se os packages .deb

####MODO EXEC (RECOMENDADO)
ENTRYPOINT ["/usr/sbin/apachectl"]
#PODE SER ENTRYPOINT giropops param1
CMD ["-D", "FOREGROUND"] #Lista de parâmetros, Rodar em primeiro plano(para nao rodar em bg, como daemon)
#Entrypoint = Processo principal. Se morrer esse o container morre.
#CMD neste caso, parâmetros pro Entrypoint, em vista de que só esse processo vai estar rodando.
#MODO SHELL nao funciona nesse caso

####MODO SHELL
CMD /usr/sbin/apachectl -D FOREGROUND

#Buildar a imagem sem cache:
docker image build -t meu_apache:2.0.0 . --no-cache

docker container run -d -p 8080:80 meu_apache:2.0.0

#Pegar o IP:
docker inspect ID | grep IP
curl localhost 8080

#Copiar arquivos para dentro da imagem ao buildar. Precisa estar no mesmo dir:
COPY index.html /var/www/html/

docker container exec -it 4599d1d3e5ab bash
#root@4599d1d3e5ab:/# ps aux
#USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
#root           1  0.0  0.0   2384  1608 ?        Ss   22:15   0:00 /bin/sh /usr/sbin/apachectl -D FOREGROUND
#root          14  0.0  0.0   8424  4888 ?        S    22:15   0:00 /usr/sbin/apache2 -D FOREGROUND
#www-data      15  0.0  0.0 1934028 4736 ?        Sl   22:15   0:00 /usr/sbin/apache2 -D FOREGROUND
#www-data      16  0.0  0.0 1933972 4020 ?        Sl   22:15   0:00 /usr/sbin/apache2 -D FOREGROUND
#root          71  0.7  0.0   3864  3188 pts/0    Ss   22:17   0:00 bash
#root          77  0.0  0.0   7636  2720 pts/0    R+   22:17   0:00 ps aux

ADD:
Como o COPY ele copia para dentro. Porém arquivos TAR ele desempacota, e arquivos da internet
ele baixa no local alvo.

#Define um usuárui para rodar:
USER www-data

#Diretório padrão do container:
WORKDIR /var/www/html/
docker container exec -it efe24fb3a8e8 bash
#root@efe24fb3a8e8:/var/www/html# 


docker container logs -f 0994de74e847
#-f, --follow         Follow log output

#mkdir: cannot create directory '/var/run/apache2': Permission denied
#apache2: Syntax error on line 80 of /etc/apache2/apache2.conf: DefaultRuntimeDir must be a valid directory, absolute or relative to ServerRoot
#Action '-D FOREGROUND' failed.
#The Apache error log may have more information.

#====
docker container logs -f bc24bbd63203
#AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to supp
#ress this message
#(13)Permission denied: AH00072: make_sock: could not bind to address 0.0.0.0:80
#no listening sockets available, shutting down
#AH00015: Unable to open logs
#Action '-D FOREGROUND' failed.
#The Apache error log may have more information.

#Somente o root tem permissao de Bindar uma porta baixa, 80.

$ docker container run -ti meu_go:1.0
Giropops Strigus Girus.

#Multiline:
RUN yum update -y && \
yum install -y apache2 \
    git \
    java \
    python

#Git
ENV MRAAVERSION v1.3.0
RUN git clone https://github.com/intel-iot-devkit/mraa.git && \
cd mraa && \
git checktout -b build ${MRAAVERSION} && \
<some build steps> make install && \ && rm -rf / root/mrraa


#DOCKER IGNORE = GIT IGNORE
.dockerignore


#CMD - Serve para executar comandos:
CMD ["giropops","param1","param2"]
CMD giropops param1 param2


#ENV como Variavel dentro do Dockerfile
ENV app_dir /opt/app_dir
WORKDIR ${app_dir}
ADD .$app_dir


#Argumento do build > Dentro da imagem no build:

FROM ubuntu
ARG CONT_IMG_VER
ENV CONT_IMG_VER v1.0.0
RUN echo $CONT_IMG_VER

$docker build --build-arg
CONT_IMG_VER=v2.0.0 Dockerfile
#vai printar: v2.0.0


#HEALTHCHECK
HEALTHCHECK --interval=5m --timeout=3s \
CMD curl -f http://lcoalhost || exit 1


$ docker container ls
#  │CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS                             PORTS                  NAMES
#  │1f2e9d10b22e        meu_apache:5.0.0    "/usr/sbin/apachectl…"   About a minute ago   Up 59 seconds (health: starting)   0.0.0.0:8080->80/tcp   vigilant_w
#  │u
#  │[  9:18 ]  [ ilhanublar@ilhanublar-desktop:~/dev/container-expert-linuxtips/docker/dockerfile/apache5_healthcheck(main✗) ]
   #  │ $ docker container ls
#   │CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS                        PORTS                  NAMES
 #  │1f2e9d10b22e        meu_apache:5.0.0    "/usr/sbin/apachectl…"   About a minute ago   Up About a minute (healthy)   0.0.0.0:8080->80/tcp   vigilant_wu
                                                                                                                                                         #│[  9:18 ]  [ ilhanublar@ilhanublar-desktop:~/dev/container-expert-linuxtips/docker/dockerfile/apache5_healthcheck(main✗) ]#

#Testar o HealthCheck:
docker container exec -ti ID bash
echo "123.21.12.12 localhost" > /etc/hosts

#Coluna Status
Up 9 minutes (unhealthy)

#Alterar um container rodando e commitar uma nova imagem:
docker container run -ti ubuntu
echo "GIROPOPS STRIGUS GIRUS" > /etc/issue
apt update && apt install vim curl
exit

docker commit -m "Ubuntu com vim e curl" ID

#Tager uma imagem:

docker image tag ID ubuntu_vim_curl:1.0

docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu_vim_curl     1.0                 d6ccb7f102be        3 minutes ago       167MB

docker container run -ti ubuntu_vim_curl:1.0

#root@7b0c0497f0d6:/# cat /etc/issue
#GIROPOPS STRIGUS GIRUS
