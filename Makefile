go:
	if [ -e src/tmp/pids/server.pid ] ; then rm src/tmp/pids/server.pid && echo 'removed pid'; fi
	docker-compose up -d
	docker attach tipjar_app_1