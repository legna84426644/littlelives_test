#!/usr/bin/env bash

ROBOT_ARGS=

function usage()
{
    echo "Usage ./run-all-tests.sh options"
    echo ""
    echo "OPTIONS:"
    echo "  -d <driver>     Select broweser: <chrome(or googlechrome or gc)(default)/firefox(or ff)/headlesschrome/headlessfirefox>"
    echo "  -h              Show this message"
    echo "  -t <subdir>     Specify Tests/<subdir> to run tests contained within"
    echo "  -x \"<args>\"   Extra arguments to pass to robot"
    echo
    exit
}

while getopts ":bc:d:hk:lm:n:r:t:u:v:wx:" opt; do
    case ${opt} in
        d)  ROBOT_ARGS+=" --variable DRIVER_TYPE:${OPTARG}"
            ROBOT_ARGS+=" --metadata Driver_type:${OPTARG}"
            ;;
        h)  usage
            ;;
        t)  TESTS_SUB_DIR="${OPTARG}/"
            ;;
        x)  ROBOT_ARGS+=" ${OPTARG}"
            ;;
    esac
done

# run all tests
python -m robot --outputdir Reports ${ROBOT_ARGS} Tests/${TESTS_SUB_DIR}