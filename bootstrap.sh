#!/usr/bin/env bash
set -e

echo "Hello Teknoir!"

tmp_dir=$(mktemp -d -t sustayn-patch-001)
echo $tmp_dir
pushd $tmp_dir

curl -Lo patch.zip https://github.com/teknoir/sustayn_os_patch_001/releases/download/test/patch.zip
echo "Please be ready to enter the zip file password:"
unzip patch.zip
echo "Applying patch!"
./patch_os.sh
echo "Patch applied successfully!"
popd
rm -rf $tmp_dir
