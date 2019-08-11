DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t megamanics/hadoop-base ./base
	docker build -t megamanics/hadoop-namenode ./namenode
	docker build -t megamanics/hadoop-datanode ./datanode
	docker build -t megamanics/hadoop-resourcemanager ./resourcemanager
	docker build -t megamanics/hadoop-nodemanager ./nodemanager
	docker build -t megamanics/hadoop-historyserver ./historyserver
	docker build -t megamanics/hadoop-submit ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} megamanics/hadoop-base hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} megamanics/hadoop-base hdfs dfs -copyFromLocal /opt/hadoop/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} megamanics/hadoop-base hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} megamanics/hadoop-base hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} megamanics/hadoop-base hdfs dfs -rm -r /input
