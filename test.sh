#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# 0.0.1
# Alexey Potehin <gnuplanet@gmail.com>, http://www.gnuplanet.ru/doc/cv
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
APP='./bin/hex2bin';
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# run app
function run_app()
{
	local RESULT=0;
	local STDOUT;

	if [ "${FLAG_VALGRIND}" != "1" ];
	then
		STDOUT=$("${APP}" "${@}");
		RESULT="${?}";
	else
		local LOG_ID=0;
		local LOG_NAME;

		while true;
		do
			LOG_NAME=$(printf "valgrind.%03u\n" ${LOG_ID});

			if [ ! -e "${LOG_NAME}" ];
			then
				break;
			fi

			(( LOG_ID++ ));
		done

		STDOUT=$(valgrind --tool=memcheck --leak-check=yes --leak-check=full --show-reachable=yes --log-file="${LOG_NAME}" "${APP}" "${@}");
		RESULT="${?}";
	fi

	if [ "${STDOUT}" != "" ];
	then
		echo "${STDOUT}";
	fi

	return "${RESULT}";
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# test1
function test1()
{
	local TMP1;
	TMP1="$(mktemp)";
	if [ "${?}" != "0" ];
	then
		echo "can't make tmp file";
		exit 1;
	fi

	local TMP2;
	TMP2="$(mktemp)";
	if [ "${?}" != "0" ];
	then
		echo "can't make tmp file";
		exit 1;
	fi

	local TMP3;
	TMP3="$(mktemp)";
	if [ "${?}" != "0" ];
	then
		echo "can't make tmp file";
		exit 1;
	fi


	echo "${MSG}" > "${TMP1}";
	cat "${TMP1}" | run_app --bin2hex > "${TMP2}";
	cat "${TMP2}" | run_app > "${TMP3}";


	if [ "${FLAG_DEBUG}" != "" ];
	then
		echo -n "data1: "; cat "${TMP1}"; echo;
		echo -n "data2: "; cat "${TMP2}"; echo;
		echo -n "data3: "; cat "${TMP3}"; echo;
	fi


	local HASH1="$(md5sum ${TMP1} | awk '{print $1}')";
	local HASH2="$(md5sum ${TMP3} | awk '{print $1}')";


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
# general function
function main()
{
	if [ ! -e "${APP}" ];
	then
		echo "ERROR: make it";
		return 1;
	fi


	check_prog "awk cat echo md5sum mktemp rm";
	if [ "${?}" != "0" ];
	then
		return 1;
	fi


	local MSG='hello fucking world!';
	test1;


	echo "ok, test passed";
	return 0;
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
main "${@}";

exit "${?}";
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
