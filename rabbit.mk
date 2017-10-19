include ../deploy/Makefile.vars


${DOWNLOADS}/rabbitmq-${RABBIT_VERSION}.tar.xz: ${DOWNLOADS}
	wget -O ${DOWNLOADS}/rabbitmq-${RABBIT_VERSION}.tar.xz ${RABBIT_URL}
	touch ${DOWNLOADS}/rabbitmq-${RABBIT_VERSION}.tar.xz


lib/rabbitmq_server-${RABBIT_VERSION} : ${DOWNLOADS}/rabbitmq-${RABBIT_VERSION}.tar.xz ${ROOT_DIR}/lib
	cd ${ROOT_DIR}/lib && tar xf ${DOWNLOADS}/rabbitmq-${RABBIT_VERSION}.tar.xz


${ROOT_DIR}/bin/rabbitmq%: lib/rabbitmq_server-${RABBIT_VERSION} ${ROOT_DIR}/bin
	ln -s -f ../lib/rabbitmq_server-${RABBIT_VERSION}/sbin/rabbitmq-server ${ROOT_DIR}/bin
	ln -s -f ../lib/rabbitmq_server-${RABBIT_VERSION}/sbin/rabbitmq-env ${ROOT_DIR}/bin
	ln -s -f ../lib/rabbitmq_server-${RABBIT_VERSION}/sbin/rabbitmqctl ${ROOT_DIR}/bin


${ROOT_DIR}/etc/rabbitmq-env.conf: ${ROOT_DIR}/etc ${ROOT_DIR}/var/log
	cp config/rabbitmq-env.conf ${ROOT_DIR}/etc


${RABBIT}: ${ROOT_DIR}/bin/rabbitmq-env

runrabbit: ${ROOT_DIR}/bin/rabbitmq-server ${ROOT_DIR}/etc/rabbitmq-env.conf
	ROOT_DIR=${ROOT_DIR} RABBITMQ_CONF_ENV_FILE=${ROOT_DIR}/etc/rabbitmq-env.conf ${ROOT_DIR}/bin/rabbitmq-server -detached

stoprabbit: ${ROOT_DIR}/bin/rabbitmqctl ${ROOT_DIR}/etc/rabbitmq-env.conf
	ROOT_DIR=${ROOT_DIR} RABBITMQ_CONF_ENV_FILE=${ROOT_DIR}/etc/rabbitmq-env.conf ${ROOT_DIR}/bin/rabbitmqctl stop
