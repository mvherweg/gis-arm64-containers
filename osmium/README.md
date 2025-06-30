# Osmium

Container version of [osmium-tool](https://github.com/osmcode/osmium-tool).

## Container

**Repository:** https://hub.docker.com/r/mvherweg/gis-arm64-osmium  
**Pull:** `docker pull mvherweg/gis-arm64-osmium:1.18.0`  

## Usage

Working directory is `/data`, easiest is to mount data of interest there and call osmium.  
Example:
```sh
osmium_verision=`cat version`
docker run -v ./test:/data docker.io/mvherweg/gis-arm64-osmium:$osmium_version fileinfo testfile.osm.pbf
```

