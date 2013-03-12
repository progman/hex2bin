#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# test1
function test1()
{
	TMP1="$(mktemp)";
	TMP2="$(mktemp)";
	TMP3="$(mktemp)";


	echo -n "${MSG}" > "${TMP1}";
	cat "${TMP1}" | ./bin/bin2hex > "${TMP2}";
	cat "${TMP2}" | ./bin/hex2bin > "${TMP3}";


	if [ "${FLAG_DEBUG}" != "" ];
	then
		echo -n "data1: "; cat "${TMP1}"; echo;
		echo -n "data2: "; cat "${TMP2}"; echo;
		echo -n "data3: "; cat "${TMP3}"; echo;
	fi


	HASH1="$(md5sum ${TMP1} | awk '{print $1}')";
	HASH2="$(md5sum ${TMP3} | awk '{print $1}')";


	if [ "${HASH1}" != "${HASH2}" ];
	then
		echo -n "data1: "; cat "${TMP1}"; echo;
		echo -n "data2: "; cat "${TMP2}"; echo;
		echo -n "data3: "; cat "${TMP3}"; echo;

		echo "ERROR: result different...";
		exit 1;
	fi


	rm "${TMP1}";
	rm "${TMP2}";
	rm "${TMP3}";
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# check depends
function check_prog()
{
	for i in ${CHECK_PROG_LIST};
	do
		if [ "$(which ${i})" == "" ];
		then
			echo "ERROR: you must install \"${i}\"...";
			echo;
			echo;
			exit 1;
		fi
	done
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
if [ ! -e ./bin/bin2hex ] || [ ! -e ./bin/hex2bin ];
then
	echo "ERROR: make it";
	exit 1;
fi


CHECK_PROG_LIST='awk cat echo md5sum mktemp rm';
check_prog;


MSG='hello fucking world!';
test1;


echo "ok, test passed";
exit 0;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
