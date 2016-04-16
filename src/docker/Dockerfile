#Credits to Sven Dowideit. Source https://docs.docker.com/examples/running_ssh_service/

#Source this image
FROM ubuntu:14.04 

MAINTAINER Naelson Douglas <naelson.dc.oliveira@gmail.com>
RUN sudo apt-get install -y software-properties-common
RUN add-apt-repository ppa:staticfloat/juliareleases
RUN add-apt-repository ppa:staticfloat/julia-deps

#install julia and ssh, if you need more packages for you application, you can add it with \ package_name
RUN apt-get update && apt-get install -y \
openssh-server \
julia  


#Account configuration
RUN mkdir /var/run/sshd
########################################################################################################################
##Change your root password here, just remove the "123" value on 'root:123' and put your own custom password for the image
#
#
#
#
RUN echo 'root:123' | chpasswd
#
#
#
#Change your root password here, just remove the "123" value on 'root:123' and put your own custom password for the image
########################################################################################################################

#ssh configuration
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/' /etc/ssh/ssh_config


#ssh keygen generation
RUN echo | ssh-keygen -t rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#Open port 22 for the ssh service
EXPOSE 22

#start sshd
CMD ["/usr/sbin/sshd", "-D"]
