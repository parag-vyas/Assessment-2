FROM ubuntu:18.04
RUN apt-get update
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh
EXPOSE 80
CMD /root/run_apache.sh
