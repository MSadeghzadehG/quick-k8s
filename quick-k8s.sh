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

function ke () {
    #kubectl exec -it "$1" bash
    ALL_PODS=($(kubectl get pods --output=jsonpath='{.items[*].metadata.name}'))
    SELECTED_PODS=()
    _get_matched_names $1 $ALL_PODS 
    echo $SELECTED_PODS
}
