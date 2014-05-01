FROM netengine/base
MAINTAINER team@netengine.com.au

# Configure redis
ADD provision /provision
RUN ansible-playbook /provision/redis.yml
RUN rm -rf /provision

# Start Runit
CMD ["/sbin/my_init"]
