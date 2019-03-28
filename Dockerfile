#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
FROM centos

#down redis
# Stable version:    
#ENV REDIS_DOWNLOAD_URL http://download.redis.io/redis-stable.tar.gz 
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-4.0.14.tar.gz

# Install Redis.
RUN \
  cd /tmp && \
  yum -y install epel-release wget make gcc gcc-c++ && \
  wget -O redis.tar.gz $REDIS_DOWNLOAD_URL && \
  mkdir redis && \
  tar -xf redis.tar.gz -C redis --strip-components=1 && \
  cd redis && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf


# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]

# Expose ports.
EXPOSE 6379
