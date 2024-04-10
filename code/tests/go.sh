# compile all the tests and copy to the SD Card
for D in *; do
    if [ -d "${D}" ]; then
        echo "${D}"
        cd ${D}
        ./go.sh
        cd ..
    fi
done
echo ""
echo "Copy files to SD Card"
cp **/*.bin /Volumes/ROSCO32
