###########build：
docker build -t wozhangkun/redis:4.0.14 redis/

##########Host optimization：
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' >> /etc/rc.local
echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf echo 'net.core.somaxconn= 511' >> /etc/sysctl.conf
sysctp -p

#############run：
docker run -tid --name redis --restart=unless-stopped -p 6377:6379 -v /data/redis:/data --sysctl net.core.somaxconn=511 wozhangkun/redis:4.0.14
#############add passwd run：
docker run -tid --name redis --restart=unless-stopped -p 6377:6379 -v /data/redis:/data --sysctl net.core.somaxconn=511 wozhangkun/redis:4.0.14 redis-server /etc/redis/redis.conf --requirepass 111111

connect：
docker logs -f redis
docker exec -ti redis redis-cli -a 111111



###########offical buled：
https://hub.docker.com/_/redis
docker run -d --name redis --restart=unless-stopped -p 6379:6379 -v /data/redis:/data --sysctl net.core.somaxconn=511 redis:4.0.14 redis-server --requirepass bsA3DuVk2JWSOiZ2YsbcrlVunQpITS --appendonly yes

