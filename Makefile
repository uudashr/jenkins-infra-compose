JENKINS_DIR=$(HOME)/temp/docker/jenkins
MASTER_DIR=$(JENKINS_DIR)/master
DIND_DIR=$(JENKINS_DIR)/dind
SLAVE_DIR=$(JENKINS_DIR)/slave

keys:
	@mkdir -p keys
	@ssh-keygen -t rsa -f keys/jenkins_slave_rsa -C "jenkins-slave"

slave.env: keys
	@echo JENKINS_SLAVE_SSH_PUBKEY=$(shell cat keys/jenkins_slave_rsa.pub) > slave.env

.PHONY: clean-master
clean-keys:
	@rm slave.env
	@rm -rf keys

.PHONY: clean-master
clean-master:
	@if [ -d $(MASTER_DIR) ]; then \
		rm -rf $(MASTER_DIR); \
	fi

.PHONY: clean-dind
clean-dind:
	@if [ -d $(DIND_DIR) ]; then \
		rm -rf $(DIND_DIR); \
	fi

.PHONY: clean-slave
clean-slave:
	@if [ -d $(SLAVE_DIR) ]; then \
		rm -rf $(SLAVE_DIR); \
	fi

.PHONY: backup
backup:
	mkdir -p backup
	tar cvf - $(JENKINS_DIR) | gzip -9 > backup/jenkins-$(shell date '+%Y%m%d_%H%M%S').tar.gz
