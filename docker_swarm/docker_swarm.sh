#Commands:
docker swarm --help
ca Display and rotate the root CA 
init Initialize a swarm
join Join a sarm as a node and/or manager
join-token Manage join tokens
leave Leave the sarm
unlock Unlock the swarm
unlock-key Manage the unlock key
update Update the swarm

#Para iniciar um Cluster:
docker swarm init

Swarm initialized: current node (6w39ta36uewdyjb7wf60gb4f0) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-2v7dgp0stninkb3p4mxki465avmgvihisji3h90hu50xvqhk3r-3d7xd1aakxazddyqvu7unaat8 192.168.0.110:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

[root@localhost ~]# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
6w39ta36uewdyjb7wf60gb4f0 *   ilha-nublar01       Ready               Active              Leader              19.03.14


#Instalar o docker em outros nós:
curl -fsSL https://get.docker.com | bash

#Fazer com que um host com docker de um join no cluster swarm:
docker swarm join --token SWMTKN-1-2v7dgp0stninkb3p4mxki465avmgvihisji3h90hu50xvqhk3r-3d7xd1aakxazddyqvu7unaat8 192.168.0.110:2377

#Listar os nodes do cluster:
docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
6w39ta36uewdyjb7wf60gb4f0 *   ilha-nublar01       Ready               Active              Leader              19.03.14
yk6y4t7f11742g6riuisxwy6g     ilha-nublar02       Ready               Active                                  20.10.1
q0hntx98ode983w5ln1tpaxo4     ilha-nublar03       Ready               Active                                  20.10.1

#Promover um node para Manager:
docker node promote ilha-nublar02

docker node ls

#Fazer com que um node saiu do Cluster:
docker swarm leave

#Remover um node a partir do Manager Leader:
docker node rm ID

#Despromover um node, para deixar de ser manager:
docker node demote nome ou ID

#Definir o IP na criação do cluster, por onde vai se comunicar:
#Caso tenha mais de uma placa de rede
docker swarm init --advertise-addr 192.168.0.1

#Regerar o comando de join no Manager, com o token:
docker swarm join-token worker


#Gerar um token para se conectar como manager.
docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-3tdexah0hte1bll306ok0ftbj51zrega1158ekymqkp9m0jk3b-2b754be86p2us9nrq1uvb1oos 192.168.0.110:2377

#Criar um novo token:
docker swarm join-token --rotate manager

#Matar o node Manager Leader:
docker swarm leave --force
#Nesse caso precisa dar init novamente no cluster swarm.

