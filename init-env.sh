#!/bin/bash

echo "init-env.sh@bash: v2.0, 20190321"
## Variables
# Write down the data required in .env file here for initiation.
ENVFILENAME=.env
ENVFILECONTENTS=(
	"# Split library id with colons and need to modify it in docker-compose file as human readable name as wel$LIBRARY_ID=ea8125af-5698-49fe-9e75-a3c260d56f31"
	"SERVER_URL="
	"USERNAME=cenk1cenk2cenk3@gmail.com"
	"PASSWORD=03018625aA!"
	"# Periodically check seafile service, default is 600s"
        "SLEEPTIME="
        )

## Script
echo "Initiating ${ENVFILENAME} file."; if [[ ! -f ${ENVFILENAME} ]] || ( echo -n ".env file already initiated. You want to override? [ y/N ]: " && read -r OVERRIDE && echo ${OVERRIDE::1} | grep -iqF "y" ); then echo "Will rewrite the .env file with the default one."; > ${ENVFILENAME} && for i in "${ENVFILECONTENTS[@]}"; do echo $i >> ${ENVFILENAME}; done; echo "Opening enviroment file in nano editor."; nano ${ENVFILENAME}; echo "All done."; else echo "File already exists with no overwrite permissiong given."; echo "Not doing anything."; fi
