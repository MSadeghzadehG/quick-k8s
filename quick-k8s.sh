#!/bin/bash

# Kubectl client aliases for faster experience

alias k="kubectl"
alias kswitch='kubectl config use-context'

_get_matched_names () {
    local match_name=$1
    shift;
    local names=("$@")
    SELECTED_PODS=()
    for name in $names; do
	if [[ ${name} == ${match_name}* ]]; then
	     SELECTED_PODS+=($name)
	fi
    done
}

_get_random_number () {
    local limit_num=$1
    SELECTED_POD_NUM=$(( ( RANDOM % $limit_num ) + 1 ))
}

function ke () {
    ALL_PODS=($(kubectl get pods --output=jsonpath='{.items[*].metadata.name}'))
    SELECTED_PODS=()
    _get_matched_names $1 $ALL_PODS 
    local number_of_selected_pods=${#SELECTED_PODS[@]}
    SELECTED_POD_NUM=1
    _get_random_number $number_of_selected_pods
    echo "${SELECTED_PODS[$SELECTED_POD_NUM]}" 
    kubectl exec -it "${SELECTED_PODS[$SELECTED_POD_NUM]}" bash
}
