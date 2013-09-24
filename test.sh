#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
APP='./bin/hex2bin';
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# run app
function run_app()
{
	STDIN=$(cat);


	if [ "${FLAG_VALGRIND}" != "1" ];
	then
		if [ "${STDIN}" != "" ];
		then
			STDOUT=$(echo "${STDIN}" | ${APP} "${@}");
		else
			STDOUT=$(${APP} "${@}");
		fi
	else
		VAL="valgrind --tool=memcheck --leak-check=yes --leak-check=full --show-reachable=yes --log-file=valgrind.log";

		STDOUT=$(echo "${STDIN}" | ${VAL} ${APP} "${@}");

		echo '--------------------------' >> valgrind.all.log;
		cat valgrind.log >> valgrind.all.log;
		rm -rf valgrind.log;
	fi


	if [ "${STDOUT}" != "" ];
	then
		echo "${STDOUT}";
	fi
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# test1
function test1()
{
	TMP1="$(mktemp)";
	TMP2="$(mktemp)";
	TMP3="$(mktemp)";


	echo "${MSG}" > "${TMP1}";
	cat "${TMP1}" | run_app --bin2hex > "${TMP2}";
	cat "${TMP2}" | run_app > "${TMP3}";


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
	for i in ${1};
	do
		if [ "$(which ${i})" == "" ];
		then
			echo "FATAL: you must install \"${i}\"...";
			return 1;
		fi
	done

	return 0;
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
if [ ! -e "${APP}" ];
then
	echo "ERROR: make it";
	exit 1;
fi


check_prog "awk cat echo md5sum mktemp rm";
if [ "${?}" != "0" ];
then
	exit 1;
fi


MSG='hello fucking world!';
test1;


echo "ok, test passed";
exit 0;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
