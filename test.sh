#!/bin/bash

if [ ! -e ./bin/bin2hex ] || [ ! -e ./bin/hex2bin ];
then
	echo "ERROR: make it";
	exit 1;
fi

TMP1="$(mktemp)";
TMP2="$(mktemp)";
TMP3="$(mktemp)";

echo 'hello fucking world!' > "${TMP1}";

cat "${TMP1}" | ./bin/bin2hex > "${TMP2}";
cat "${TMP2}" | ./bin/hex2bin > "${TMP3}";

HASH1="$(md5sum ${TMP1} | awk '{print $1}')";
HASH2="$(md5sum ${TMP3} | awk '{print $1}')";

if [ "${HASH1}" != "${HASH2}" ];
then
	echo "ERROR: very strange...";
	echo -n "data1: "; cat "${TMP1}"; echo;
	echo -n "data2: "; cat "${TMP2}"; echo;
	echo -n "data3: "; cat "${TMP3}"; echo;
	exit 1;
fi


rm "${TMP1}";
rm "${TMP2}";
rm "${TMP3}";

echo "ok";

exit 1;
