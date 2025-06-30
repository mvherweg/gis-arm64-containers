#!/usr/bin/env sh

osmium_version=`cat version`


# Check whether podman is present, else fall back to docker
command -v podman > /dev/null 2>&1
if [ "$?" = "0" ]; then
    docker_cmd=podman
else
    docker_cmd=docker
fi


script_dir=`dirname "$0"`
container_name="docker.io/mvherweg/gis-arm64-osmium:$osmium_version"
exit_code=0


# Test fileinfo
actual_out=`$docker_cmd run -v "$script_dir/test":/data $container_name fileinfo testfile.osm.pbf`
expected_out=`cat $script_dir/test/fileinfo-expected.out`

if [ "$actual_out" = "$expected_out" ]; then
    echo "fileinfo: pass."
else
    echo "fileinfo: fail!"
    echo "===============================  EXPECTED OUTPUT ==============================="
    echo "$expected_out"
    echo "================================  ACTUAL OUTPUT ================================"
    echo "$actual_out"
    echo "=====================================  END ====================================="
    exit_code=1
fi


# Test cat
actual_out=`$docker_cmd run -v "$script_dir/test":/data $container_name cat -f osm.bz2 testfile.osm.pbf | md5sum`
expected_out=`cat $script_dir/test/cat-expected.osm.bz2 | md5sum`


if [ "$actual_out" = "$expected_out" ]; then
    echo "cat: pass."
else
    echo "cat: fail!"
    echo "=============================  EXPECTED MD5 CHECKSUM ==========================="
    echo "$expected_out"
    echo "=============================== ACTUAL MD5 CHECKSUM ============================"
    echo "$actual_out"
    echo "=====================================  END ====================================="
    exit_code=1
fi


exit $exit_code

