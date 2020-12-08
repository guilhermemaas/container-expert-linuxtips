#Verificar recursos sendo gastos pelo container:
docker container stats ID/Name

#Testar processamento nginx:
while true; do curl 172.17.0.3; done

#Teste de stress:
stress --cpu 1 --vm-bytes 128M --vm 1

#Top - verificar processos:
docker container top ID/Name

#Definir max memory:
dcoker container run -d -m 128M nginx

#"Memory": 134217728
#bc
#134217728/1024/1024 = 128

#Definir uso por core:
docker container run -d -m 128M --cpus 0.5 nginx
#Nesse caso 50% de 1 core.
"Memory": 134217728,
"NanoCpus": 500000000 #0.5cpu

#cat /proc/cpuinfo -> Inf. Sobre os nucleos

#Update de uso de cpu em um container em exe.:
docker container update --cpus 0.2 fc8d10dfd97a

#Update mem.:
docker container update --cpus 0.8 --memory 64M fc8d10dfd97a