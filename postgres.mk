include ../run-billing-deploy/Makefile.vars

${ROOT_DIR}/var/db/base: ${ROOT_DIR}/var
	install -m 700 -d ${ROOT_DIR}/var/db/
	[ -e  ${ROOT_DIR}/var/db/base ] || initdb ${ROOT_DIR}/var/db/
	touch ${ROOT_DIR}/var/db/base

runpg: ${POSTGRES} ${ROOT_DIR}/var/db/base ${ROOT_DIR}/run
	${POSTGRES} -D ${ROOT_DIR}/var/db/ -c log_destination=stderr -c unix_socket_directories=${ROOT_DIR}/run/ &