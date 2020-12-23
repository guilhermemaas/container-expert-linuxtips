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

docker service create --name giropops -3 -p 8080:80

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

[root@localhost ~]# docker service scale giropops=10
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

