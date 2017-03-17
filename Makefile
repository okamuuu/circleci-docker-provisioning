docker.keygen:
	ssh-keygen -P "" -f keys/docker_id_rsa

docker.build:
	docker build -t provisioning_sshd .

docker.start:
	docker run -d -p 40122:22 --name test_sshd provisioning_sshd

docker.stop:
	ssh-keygen -R "[localhost]:40122"
	docker rm -f `docker ps -aq`

docker.provision:
	ansible-playbook ./provisioning/playbook.yml -i ./provisioning/inventory/docker

docker.provision.ci:
	ansible-playbook ./provisioning/playbook.yml -i ./provisioning/inventory/docker --private-key=./keys/docker_id_rsa

docker.test:
	test `ssh docker@localhost -p 40122 -i keys/docker_id_rsa 'node -v'` = "v6.10.0"
	@echo "It looks like optimal"
