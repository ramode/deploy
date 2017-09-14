include Makefile.vars

include rabbit.mk
include python.mk

all: ${ROOT_DIR}/var/db ${ROOT_DIR}/run


${DOWNLOADS}:
	install -m 770 -d ${DOWNLOADS}

${ROOT_DIR}/bin:
	install -m 770 -d ${ROOT_DIR}/bin

${ROOT_DIR}/lib:
	install -m 770 -d ${ROOT_DIR}/lib

${ROOT_DIR}/etc:
	install -m 770 -d ${ROOT_DIR}/etc

${ROOT_DIR}/var:
	install -m 700 -d ${ROOT_DIR}/var/

${ROOT_DIR}/var/log: ${ROOT_DIR}/var
	install -m 700 -d ${ROOT_DIR}/var/log/

${ROOT_DIR}/var/db: ${ROOT_DIR}/var
	install -m 700 -d ${ROOT_DIR}/var/db/
	initdb ${ROOT_DIR}/var/db/

${ROOT_DIR}/run:
	install -m 700 -d ${ROOT_DIR}/run

runpg: ${ROOT_DIR}/var/db ${ROOT_DIR}/run
	postgres -D ${ROOT_DIR}/var/db/ -c log_destination=stderr -c unix_socket_directories=${ROOT_DIR}/run/





