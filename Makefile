

build:
	docker build -t nullstyle/osrm-produce .

push: build
	docker push nullstyle/osrm-produce

bash: build
	docker run -it --rm nullstyle/osrm-produce /bin/bash

run:
	docker run -it --rm --name osrm-api -v ./osrm-data:/osrm-data nullstyle/osrm-produce osrm north-america-latest "http://download.geofabrik.de/north-america-latest.osm.pbf"
frontend:
	docker run --rm --link osrm-api:api --name osrm-front -p 8080:80 cartography/osrm-frontend-docker

docker run --rm -it --name osrm-api -v /home/nullstyle:/osmr-data nullstyle/osrm-backend-docker /bin/bash
