#!/usr/bin/env bash
set -xe

echo "Hello Teknoir!"

tmp_dir=$(mktemp -d -t sustayn-patch-XXXXXXXXXX)
echo $tmp_dir
pushd $tmp_dir

curl -o patch.zip https://github.com/teknoir/sustayn_os_patch_001/releases/download/test/patch.zip
unzip patch.zip
ls -la ./files

popd
rm -rf $tmp_dir
