docker image build -t meu_apache:1.0.0 .

docker image list
#REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
#meu_apache          1.0.0               9f0e6f703405        44 seconds ago      250MB

dpkg -l | grep apache #Verificar se os packages .deb

####MODO EXEC (RECOMENDADO)
ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"] #Lista de parâmetros, Rodar em primeiro plano(para nao rodar em bg, como daemon)
#Entrypoint = Processo principal. Se morrer esse o container morre.
#CMD neste caso, parâmetros pro Entrypoint, em vista de que só esse processo vai estar rodando.
#MODO SHELL nao funciona nesse caso

####MODO SHELL
CMD /usr/sbin/apachectl -D FOREGROUND