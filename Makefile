

run:
	docker build -t nullstyle/osrm-backend-docker .
	docker run -it --rm --name osrm-api -v /osrm-data:/osrm-data -p 5000:5000 nullstyle/osrm-backend-docker osrm north-america-latest "http://download.geofabrik.de/north-america-latest.osm.pbf"

frontend:
	docker run --rm --link osrm-api:api --name osrm-front -p 8080:80 cartography/osrm-frontend-docker

docker run --rm -it --name osrm-api -v /home/nullstyle:/osmr-data nullstyle/osrm-backend-docker /bin/bash
