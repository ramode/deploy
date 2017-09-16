include Makefile.vars

run: runpg runrabbit

include rabbit.mk
include python.mk
include postgres.mk

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

${ROOT_DIR}/run:
	install -m 700 -d ${ROOT_DIR}/run







