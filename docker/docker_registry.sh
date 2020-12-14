docker container run -d -p 5000:5000 --restart=always --name registry registry:2
#--restart=always => Qualquer problema ele vai subir o container novamente.

#Deslogar do Dockerhub:
docker logout

#Tagear a imagem para o registry local:
ocker image tag 2cbc1839271d localhost:5000/meu_apache:1.0.0

#Fazer push da imagem:
docker image push localhost:5000/meu_apache

#Fazer pull/rodar:
docker container run -d -p 8080:80 localhost:5000/meu_apache:1.0.0

#Como verificar as imagens que estao no registry local:
curl localhost:5000

#Ver as tags de uma imagem:
curl localhost:5000/v2/meu_apache/tags/list

 $ curl localhost:5000/v2/_catalog
{"repositories":["meu_apache"]}

 $ curl localhost:5000/v2/meu_apache/tags/list
{"name":"meu_apache","tags":["1.0.0"]}