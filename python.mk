include ../run-billing-deploy/Makefile.vars

${DOWNLOADS}/Python-${PYTHON_VERSION}.tar.xz: ${DOWNLOADS}
	wget -O ${DOWNLOADS}/Python-${PYTHON_VERSION}.tar.xz ${PYTHON_URL}
	touch ${DOWNLOADS}/Python-${PYTHON_VERSION}.tar.xz


${DOWNLOADS}/Python-${PYTHON_VERSION}: ${DOWNLOADS}/Python-${PYTHON_VERSION}.tar.xz
	tar -C ${DOWNLOADS}/ -x -f ${DOWNLOADS}/Python-${PYTHON_VERSION}.tar.xz

${DOWNLOADS}/Python-${PYTHON_VERSION}/Makefile: ${DOWNLOADS}/Python-${PYTHON_VERSION}
	install -m 770 -d ${ROOT_DIR}/lib/Python-${PYTHON_VERSION}
	cd ${DOWNLOADS}/Python-${PYTHON_VERSION}/ && ${DOWNLOADS}/Python-${PYTHON_VERSION}/configure --prefix=${ROOT_DIR}/lib/Python-${PYTHON_VERSION}

${ROOT_DIR}/lib/Python-${PYTHON_VERSION}/bin/python${PYTHON_MAJOR}: ${DOWNLOADS}/Python-${PYTHON_VERSION}/Makefile
	make -C ${DOWNLOADS}/Python-${PYTHON_VERSION}
	make -C ${DOWNLOADS}/Python-${PYTHON_VERSION} install


${ROOT_DIR}/bin/python${PYTHON_MAJOR}: ${ROOT_DIR}/lib/Python-${PYTHON_VERSION}/bin/python${PYTHON_MAJOR} ${ROOT_DIR}/bin
	ln -f -s ${ROOT_DIR}/lib/Python-${PYTHON_VERSION}/bin/python${PYTHON_MAJOR} ${ROOT_DIR}/bin/python${PYTHON_MAJOR}


python: ${PYTHON}
	echo ${PYTHON}
