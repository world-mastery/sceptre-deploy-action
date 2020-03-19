#!/usr/bin/env bash

if [[ -z "${INPUT_AWS_ACCESS_KEY_ID}" ]]; then
    echo "AWS_ACCESS_KEY_ID is missing"
    exit 1
fi

if [[ -z "${INPUT_AWS_SECRET_ACCESS_KEY}" ]]; then
    echo "AWS_SECRET_ACCESS_KEY is missing"
    exit 1
fi

if [[ -z "${INPUT_AWS_REGION}" ]]; then
    echo "AWS_REGION is missing"
    exit 1
fi

if [[ -z "${INPUT_SCEPTRE_BASE_DIRECTORY}" ]]; then
    echo "SCEPTRE_BASE_DIRECTORY is missing"
    exit 1
fi

if [[ -z "${INPUT_SCEPTRE_PATH}" ]]; then
    echo "SCEPTRE_PATH is missing"
    exit 1
fi

## Set AWS credentials
export AWS_ACCESS_KEY_ID="${INPUT_AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${INPUT_AWS_SECRET_ACCESS_KEY}"
export AWS_REGION="${INPUT_AWS_REGION}"

## Prepare variables and execute sceptre inside proper directory
pushd "${INPUT_SCEPTRE_BASE_DIRECTORY}"
    INPUT_VARS=$(env | grep "^VARS_")

    VARS=""
    if [[ ! -z "$INPUT_VARS" ]]; then
        for INPUT_VAR in ${INPUT_VARS}
        do
            var=$(echo "${INPUT_VAR}" | sed "s/^VARS_//" | tr '[:upper:]' '[:lower:]')
            VARS+=" --var $var"
        done
    fi

    DEBUG_CONFIG=""
    if [[ "$INPUT_DEBUG" == "on" ]]; then
        DEBUG_CONFIG="--debug"
    fi

    exec /usr/local/bin/sceptre ${DEBUG_CONFIG} ${VARS} launch -y "${INPUT_SCEPTRE_PATH}"
popd
