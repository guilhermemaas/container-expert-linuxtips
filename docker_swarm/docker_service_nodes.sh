#Inscpect no node:
docker node inspect ilha-nublar03

#Node update:
docker node update --availability pause ilha-nublar03

#Inspect:
docker node inspect ilha-nublar03 | grep Availability
"Availability": "pause"

#Node update:
docker node update --availability active ila-nublar03

[root@localhost ~]# docker node inspect ilha-nublar03 | grep Availability
            "Availability": "active"


#Escalar servicos de nginx entre os nodes:
docker service create --name webserver --replicas 3 -p 8080:80 nginx

#Verificar a distribuição entre os nodes:
docker service ps webserver

#Escalar mais replicas de um service:
docker service scale webserver=10

docker service ps webserver
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE                     ERROR                              PORTS
94j3ulghia4m        webserver.1         nginx:latest        ilha-nublar01       Running             Running 5 minutes ago                                                
zbk70lqe5jz6        webserver.2         nginx:latest        ilha-nublar02       Running             Running less than a second ago                                       
qblg6zoie0dl         \_ webserver.2     nginx:latest        ilha-nublar02       Shutdown            Rejected less than a second ago   "No such image: nginx:latest@s…"   
0f3ge6z7atyw        webserver.3         nginx:latest        ilha-nublar02       Running             Running less than a second ago                                       
dnp880zoe79m         \_ webserver.3     nginx:latest        ilha-nublar02       Shutdown            Rejected less than a second ago   "No such image: nginx:latest@s…"   
t1j5l55bkyuv        webserver.4         nginx:latest        ilha-nublar01       Running             Running 16 seconds ago                                               
vhxn0gqcax73        webserver.5         nginx:latest        ilha-nublar02       Running             Running less than a second ago                                       
jow7sgdc15mi        webserver.6         nginx:latest        ilha-nublar01       Running             Running 17 seconds ago                                               
u5d78kgv818v        webserver.7         nginx:latest        ilha-nublar01       Running             Running 14 seconds ago                                               
mhrn3rzkde8o        webserver.8         nginx:latest        ilha-nublar02       Running             Running less than a second ago                                       
rxi6lxkhaaz0        webserver.9         nginx:latest        ilha-nublar01       Running             Running 16 seconds ago                                               
ob09crbnu6hq        webserver.10        nginx:latest        ilha-nublar02       Running             Running less than a second ago    

#Remover um service:
docker service rm webserver


#===========================
#SERVICES
#===========================

docker service --help

Commands:
  create      Create a new service
  inspect     Display detailed information on one or more services
  logs        Fetch the logs of a service or task
  ls          List services
  ps          List the tasks of one or more services
  rm          Remove one or more services
  rollback    Revert changes to a services configuration
  scale       Scale one or multiple replicated services
  update      Update a servic

  
#Criar um service, quando bindamos uma porta 8080:80, vai bindar em todos os nodes, qualquer requisição na porta 8080, vai
#direcionar para a 80 nos containers.
#Mesmo que o service só tenha sido configurado para replicar em um node.

docker service create --name giropops --replicas 3 -p 8080:80 nginx

docker service ls
#ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
#vam9uemfgcpp        giropops            replicated          3/3                 nginx:latest        *:8080->80/tcp

#Mode:
#Replicated = Consegue escolher a quantidade de réplicas.
#Globarl 

#Para ver onde estão rodando os containers do serviço:
docker service ps giropops
docker service inspect giropops --pretty

ID:             vam9uemfgcppdvgpcrqn85a1j
Name:           giropops
Service Mode:   Replicated
 Replicas:      3
Placement:
UpdateConfig:
 Parallelism:   1
 On failure:    pause
 Monitoring Period: 5s
 Max failure ratio: 0
 Update order:      stop-first
RollbackConfig:
 Parallelism:   1
 On failure:    pause
 Monitoring Period: 5s
 Max failure ratio: 0
 Rollback order:    stop-first
ContainerSpec:
 Image:         nginx:latest@sha256:4cf620a5c81390ee209398ecc18e5fb9dd0f5155cd82adcbae532fec94006fb9
 Init:          false
Resources:
Endpoint Mode:  vip
Ports:
 PublishedPort = 8080
  Protocol = tcp
  TargetPort = 80
  PublishMode = ingress 

#Escalar para 10 giropops
docker service scale giropops=10

docker service scale giropops=10
giropops scaled to 10
overall progress: 10 out of 10 tasks 
1/10: running   [==================================================>] 
2/10: running   [==================================================>] 
3/10: running   [==================================================>] 
4/10: running   [==================================================>] 
5/10: running   [==================================================>] 
6/10: running   [==================================================>] 
7/10: running   [==================================================>] 
8/10: running   [==================================================>] 
9/10: running   [==================================================>] 
10/10: running   [==================================================>] 
verify: Service converged 

#Verificar logs de um serviço:
docker service logs -f giropops
giropops.7.4kejzhv0zo9a@ilha-nublar01     | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
giropops.7.4kejzhv0zo9a@ilha-nublar01     | 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
giropops.7.4kejzhv0zo9a@ilha-nublar01     | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
giropops.7.4kejzhv0zo9a@ilha-nublar01     | /docker-entrypoint.sh: Configuration complete; ready for start up
giropops.3.wdo0rvd2wzql@ilha-nublar01     | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
giropops.3.wdo0rvd2wzql@ilha-nublar01     | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
giropops.3.wdo0rvd2wzql@ilha-nublar01     | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
giropops.3.wdo0rvd2wzql@ilha-nublar01     | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
giropops.3.wdo0rvd2wzql@ilha-nublar01     | 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
giropops.3.wdo0rvd2wzql@ilha-nublar01     | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
giropops.3.wdo0rvd2wzql@ilha-nublar01     | /docker-entrypoint.sh: Configuration complete; ready for start up

#Curl de dentro do node ilha-nublar02 para o IP do node ilha-nublar03:
curl 192.168.0.117:8080
giropops.10.v58k53tf7ewy@ilha-nublar03    | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
giropops.10.v58k53tf7ewy@ilha-nublar03    | /docker-entrypoint.sh: Configuration complete; ready for start up
giropops.5.pb6iw5fpg894@ilha-nublar01     | 10.0.0.5 - - [21/Dec/2020:07:48:49 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"


#=================
#SERVICE VOLUME:
#=================

####LAB
docker volume create giropops
cd /var/lib/docker/volumes/giropops/_data/
vim index.html

docker service create --name giropops --replicas 3 -p 8080:80 --mount type=volume,src=giropops,dst=/usr/share/nginx/html/ nginx

docker service logs -f giropops
giropops.1.l553rasv7tck@ilha-nublar02    | 10.0.0.2 - - [23/Dec/2020:17:47:28 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.3.6lwpu8dgp21x@ilha-nublar03    | 10.0.0.2 - - [23/Dec/2020:01:45:35 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.2.l1dacb52ekk3@ilha-nublar01    | 10.0.0.2 - - [21/Dec/2020:08:04:05 +0000] "GET / HTTP/1.1" 200 28 "-" "curl/7.61.1" "-"
giropops.1.l553rasv7tck@ilha-nublar02    | 10.0.0.2 - - [23/Dec/2020:17:47:33 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.3.6lwpu8dgp21x@ilha-nublar03    | 10.0.0.2 - - [23/Dec/2020:01:45:37 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.2.l1dacb52ekk3@ilha-nublar01    | 10.0.0.2 - - [21/Dec/2020:08:04:07 +0000] "GET / HTTP/1.1" 200 28 "-" "curl/7.61.1" "-"
giropops.1.l553rasv7tck@ilha-nublar02    | 10.0.0.2 - - [23/Dec/2020:17:47:34 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.3.6lwpu8dgp21x@ilha-nublar03    | 10.0.0.2 - - [23/Dec/2020:01:45:39 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.2.l1dacb52ekk3@ilha-nublar01    | 10.0.0.2 - - [21/Dec/2020:08:04:08 +0000] "GET / HTTP/1.1" 200 28 "-" "curl/7.61.1" "-"
giropops.1.l553rasv7tck@ilha-nublar02    | 10.0.0.2 - - [23/Dec/2020:17:47:36 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"
giropops.3.6lwpu8dgp21x@ilha-nublar03    | 10.0.0.2 - - [23/Dec/2020:01:45:41 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.61.1" "-"

#Curl de um dos nós, hora bate em um nó com o index.html padrão, outra hora no nó que possui o volume com index.html modificado:
#STRIGUS GIRUS XPTO:

[root@ilha-nublar03 ~]# curl 192.168.0.110:8080
GIROPOPS STRIGUS GIRUS 2.0.

[root@ilha-nublar03 ~]# curl 192.168.0.110:8080                                                                                                           
<!DOCTYPE html>                                                                                                                                           
<html>                                                                                                                                                    
<head>                                                                                                                                                    
<title>Welcome to nginx!</title>                                                                                                                          
<style>                                                                                                                                                   
    body {                                                                                                                                                
        width: 35em;                                                                                                                                      
        margin: 0 auto;                                                                                                                                   
        font-family: Tahoma, Verdana, Arial, sans-serif;  

#SERVIDOR NFS para compartilhar um dir como volume nos nodes:
#No Server NFS:
apt install nfs-server
vim /etc/exports
/opt/site *(rw,sync,subtree_check)
mkdir -p /opt/site/_data
echo "GIROPOPS STRIGUS GIRUS" > /opt/site/_data/index.html
docker volume create giropops
rm -rf /var/lib/docker/volumes/giropops/_data/
ln -s /opt/site/_data/ /var/lib/docker/volumes/giropops/
exportfs -ar
#No Client NFS, ou seja, nos nodes swarm:
apt install nfs-common
showmount -e IP
mount IP:/opt/site /var/lib/docker/volumes/giropops
#Criar o service:
docker service create --name giropops --replicas 3 -p 8080:80 --mount type=volume,src=giropops,dst=/usr/share/nginx/html nginx

#LAB TESTE - Nesse caso temos o nfs montado em 2 dos 3 nodes, assim ao chamar 2 em 3 retorna a index do volume:
[root@ilha-nublar03 _data]# curl 192.168.0.117:8080
GIROPOPS STRIGUS GIRUS
[root@ilha-nublar03 _data]# curl 192.168.0.117:8080
GIROPOPS STRIGUS GIRUS
[root@ilha-nublar03 _data]# curl 192.168.0.117:8080
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
[root@ilha-nublar03 _data]# 


#=================
#SERVICE NETWORK:
#=================

docker service update --help

Options:
      --blkio-weight uint16        Block IO (relative weight), between 10 and 1000, or 0 to disable (default 0)
      --cpu-period int             Limit CPU CFS (Completely Fair Scheduler) period
      --cpu-quota int              Limit CPU CFS (Completely Fair Scheduler) quota
      --cpu-rt-period int          Limit the CPU real-time period in microseconds
      --cpu-rt-runtime int         Limit the CPU real-time runtime in microseconds
  -c, --cpu-shares int             CPU shares (relative weight)
      --cpus decimal               Number of CPUs
      --cpuset-cpus string         CPUs in which to allow execution (0-3, 0,1)
      --cpuset-mems string         MEMs in which to allow execution (0-3, 0,1)
      --kernel-memory bytes        Kernel memory limit
  -m, --memory bytes               Memory limit
      --memory-reservation bytes   Memory soft limit
      --memory-swap bytes          Swap limit equal to memory plus swap: '-1' to enable unlimited swap
      --pids-limit int             Tune container pids limit (set -1 for unlimited)
      --restart string             Restart policy to apply when a container exits


#docker service create, outras opções:
docker service create --name giropops --replicas 3 -p 8080:80 --mount type=volume,src=giropops,dst=/usr/share/nginx/html --hostname xpto_name --limit-cpu 0.25 --limit-memory 64M --env curso=linuxtips --dns 8.8.8.8 nginx

[root@ilha-nublar01 etc]# docker exec -ti 896645ffc8b4 bash
root@xpto_name:/# 

root@xpto_name:/# env | grep curso
curso=linuxtips


#Criando uma rede:
docker network create -d overlay giropops
docker network create -d overlay strigus
#Overlay = Para Swarm, todos nessa rede consegue conversar entre si.

#Criar 3 Servicos, 2 em uma rede, e um terceiro em outra
docker service create --name nginx1 -p 8080:80 --network giropops nginx
docker service create --name nginx2 -p 8880:80 --network giropops nginx
#docker exec -ti ID bash
#curl nginx1 ou nginx2
#Resolve pelo nome do servico. Vai ficar caindo de forma distribuida as requisicoes entre os nodes, containers.
root@2bac33fcda21:/# history
    1  echo "GIROPOPS" > /usr/share/nginx/html/index.html
    2  curl nginx1
    3  curl nginx1
    4  curl nginx1
    5  curl nginx1
    6  curl nginx1
    7  curl nginx1
    8  curl nginx1
    9  curl nginx1
   10  curl nginx1
   11  curl nginx1
   12  curl nginx1
   13  curl nginx1
   14  curl nginx1
   15  curl nginx1
   16  curl nginx1
   17  curl nginx1
   18  curl nginx1
   19  curl nginx1
   20  curl nginx1
   21  history

docker service create --name nginx3 -p 8980:80 --network strigus nginx

#Adicionar uma rede existente a um servico, para que os containers possam se comunicar com essa rede.
docker service update --network-add strigus nginx1
[root@ilha-nublar01 etc]# docker service update --network-add strigus nginx1
nginx1
overall progress: 10 out of 10 tasks 
1/10: running   [==================================================>] 
2/10: running   [==================================================>] 
3/10: running   [==================================================>] 
4/10: running   [==================================================>] 
5/10: running   [==================================================>] 
6/10: running   [==================================================>] 
7/10: running   [==================================================>] 
8/10: running   [==================================================>] 
9/10: running   [==================================================>] 
10/10: running   [==================================================>] 
verify: Service converged 

root@ae0175e5e996:/# history
    1  curl strigus
    2  clear
    3  curl nginx1
    4  curl nginx2
    5  curl nginx3

#Adicionar uma porta com update em um service:
docker service update --publish-add 9090:9090

#Para visualizar as configs da netowrk
docker network inspect strigus
