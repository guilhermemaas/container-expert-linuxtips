#----------------------
#TIPO BIND
#----------------------

#Volume do tipo Bind. Quando montamos um diretório do SO dentro do container:
mkdir /opt/giropops
docker container run -ti --mount type=bind,src=/opt/giropops,dst=/giropops debian
#root@78d1faa1c850:/# ls /
#bin  boot  dev  etc  giropops  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

#root@9f8ae4d814f5:/giropops# df -h
#Filesystem           Size  Used Avail Use% Mounted on
#overlay              6.2G  2.6G  3.6G  42% /
#tmpfs                 64M     0   64M   0% /dev
#tmpfs                914M     0  914M   0% /sys/fs/cgroup
#shm                   64M     0   64M   0% /dev/shm
#/dev/mapper/cl-root  6.2G  2.6G  3.6G  42% /giropops
#tmpfs                914M     0  914M   0% /proc/asound
#tmpfs                914M     0  914M   0% /proc/acpi
#tmpfs                914M     0  914M   0% /proc/scsi
#tmpfs                914M     0  914M   0% /sys/firmware

#Montar volume somente como Read Only:
docker container run -ti --mount type=bind,src=/opt/giropops,dst=/giropops,ro debian
#root@ea113e323e42:/giropops# touch teste3.txt
#touch: cannot touch 'teste3.txt': Read-only file system


#----------------------
#TIPO VOLUME
#----------------------

#Visualizar volumes criados:
docker volumes ls

#Criar um volume:
docker volume create giropops
docker volume ls
#[root@localhost ~]# docker volume ls
#DRIVER              VOLUME NAME
#local               giropops

#Visualizar detalhes do volume:
docker volume inspect giropops
[root@localhost ~]# docker volume inspect giropops
#[
#    {
#        "CreatedAt": "2020-12-08T11:23:24-03:00",
#        "Driver": "local",
#        "Labels": {},
#        "Mountpoint": "/var/lib/docker/volumes/giropops/_data",
#        "Name": "giropops",
#        "Options": {},
#        "Scope": "local"
#    }
#]

#Criar um container com Volume:
docker container run -ti --mount type=volume,src=giropops,dst/giropops debian
#[root@localhost ~]# docker container exec -ti b2b481103d9e touch /giropops/XPTO.txt
#[root@localhost ~]# ls /var/lib/docker/volumes/giropops/_data/
#2a6961882506.txt  GIROPOPS.txt  STRIGUS.txt  XPTO.txt

#Remover volume (Nao podem existir containers dependentes)
docker volume rm giropops
#[root@localhost _data]# docker volume rm giropops
#Error response from daemon: remove giropops: volume is in use - [b2b481103d9ed722b6eb94000ceeb4223bbda86e3273c140fc81dd64865bd905, 2a696188250692862adcf977de4335d4e25480cb5533afbad5a03dcbec80ab47]
#[root@localhost _data]# docker container rm -f b2b481103d9ed722b6eb94000ceeb4223bbda86e3273c140fc81dd64865bd905
#b2b481103d9ed722b6eb94000ceeb4223bbda86e3273c140fc81dd64865bd905
#[root@localhost _data]# docker container rm -f 2a696188250692862adcf977de4335d4e25480cb5533afbad5a03dcbec80ab47
#2a696188250692862adcf977de4335d4e25480cb5533afbad5a03dcbec80ab47
#[root@localhost _data]# docker volume rm giropops
##giropops

#----------------------
#Data-Only e Prune
#----------------------

docker volume create giropops
docker container run -ti --mount type=volume,src=giropops,dst=/giropops debian
docker inspect f42100028f4d
#        "Mounts": [                                                                                                                                      
#    {                                                                                                                                            
#        "Type": "volume",                                                                                                                        
#        "Name": "giropops",                                                                                                                      
#        "Source": "/var/lib/docker/volumes/giropops/_data",                                                                                      
#        "Destination": "/giropops",                                                                                                              
#        "Driver": "local",                                                                                                                       
#        "Mode": "z",                                                                                                                             
#        "RW": true,                                                                                                                              
#        "Propagation": ""                                                                                                                        
#    }                                                                                                                                            
#],                              

docker volume prune
#Remove todos os volumes que nao estao vinculados a um container.

######Para remover todos os containers que estao parados:
docker container prune

#Criar um container DataOnly, para um DataBase por exemplo. Hoje em dia não é mais usado:
docker container create -v /data --name dbdados centos
#-v /data(Dentro do Container) - No caso o PostgreSQL usa esse dir, [e um exemplo.

docker container run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker 
-e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/PostgreSQL

#-d, --detach                         Run container in background and print container ID
#-e, --env list                       Set environment variables

#docker container inspect imagem_do_container_volume_only
#"Mounts": [
#            {
#                "Type": "volume",
#                "Name": "4a8ba108f665b94ddd2ab2a381dd791c5f7e6a9cb533262eba4d29f875d14abe",
#                "Source": "/var/lib/docker/volumes/4a8ba108f665b94ddd2ab2a381dd791c5f7e6a9cb533262eba4d29f875d14abe/_data",
#                "Destination": "/data",
#                "Driver": "local",
#                "Mode": "",
#                "RW": true,
#                "Propagation": ""
#            }
#        ],

#[root@localhost ~]# ls /var/lib/docker/volumes/4a8ba108f665b94ddd2ab2a381dd791c5f7e6a9cb533262eba4d29f875d14abe/_data
#base    pg_clog      pg_ident.conf  pg_notify  pg_snapshots  pg_stat_tmp  pg_tblspc    PG_VERSION  postgresql.conf  postmaster.pid  server.key
#global  pg_hba.conf  pg_multixact   pg_serial  pg_stat       pg_subtrans  pg_twophase  pg_xlog     postmaster.opts  server.crt

#Fazendo uma conexao no banco:

#=========================DESAFIO
#================================
#Subir 2 containers docker apontando para um volume
docker container volume create pg_data
ls /var/lib/docker/volumes/pg_data/_data/
docker container run -d -p 5432:5432 --name pgsql1 --mount type=volume,src=pg_data,dst=/data -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql
docker container run -d -p 5433:5432 --name pgsql2 --mount type=volume,src=pg_data,dst=/data -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql
docker container run -d -p 5431:5432 --name pgsql3 --mount type=volume,src=pg_data,dst=/data -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker kamui/postgresql #Vai criar um container sem um banco novo, usando o que já existe.
export PGUSER=docker PGPASSWORD=docker PGHOST=localhost PGPORT=5433; psql -l
CREATE TABLE XPTO(
    name varchar(30)
);

#----------------------
#CRIAR UM CONTAINER PRA FAZER O BKP DO POSTGRES
#----------------------

mkdir /opt/backup 
docker container run -it --mount type=volume,src=pg_data,dst=/data --mount type=bind,src=/opt/backup,dst=/backup debian tar -cvf /backup/bkp-banco.tar /data
cd /opt/backup
tar -xvf bkb-banco.tar
tar:
    -x = extrair
    -v = verbose
    -f = file
    -c = criar

