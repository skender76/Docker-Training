FROM debian:jessie
RUN apt-get update  
RUN apt-get install -y git
RUN apt-get install -y vim
CMD ["echo","Container Is Up And Running"]

