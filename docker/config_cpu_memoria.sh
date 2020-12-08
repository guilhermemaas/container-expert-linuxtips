#Verificar recursos sendo gastos pelo container:
docker container stats ID/Name

#Testar processamento nginx:
while true; do curl 172.17.0.3; done

#Teste de stress:
stress --cpu 1 --vm-bytes 128M --vm 1