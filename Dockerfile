FROM phusion/baseimage:0.9.9
MAINTAINER team@netengine.com.au

# http://phusion.github.io/baseimage-docker/
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

# The redis service
RUN apt-get update
RUN apt-get install -y redis-server
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 6379

ADD https://gist.githubusercontent.com/dansowter/7e04518c0e1dedc85e78/raw/a0449efefba2ebd539b158b13a3b17931b0b1a2a/ne_team_public_keys /tmp/ne_keys
RUN cat /tmp/ne_keys >> /root/.ssh/authorized_keys && rm -f /tmp/ne_keys

# Add redis service to runit
RUN mkdir /etc/service/redis
ADD redis.sh /etc/service/redis/run
