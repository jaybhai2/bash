```
nohup bin/kafka-server-start.sh config/server.properties > ~/kafka_nohup.out 2> ~/kafka_nohup.err < /dev/null &


nohup python -u wait.py > log.out 2>err.out &


ps aux | grep "wait.py"

# jobs -l # to list running nohup job in current shell session. OR ps -ef | grep "nohup "
# jps -l




```
