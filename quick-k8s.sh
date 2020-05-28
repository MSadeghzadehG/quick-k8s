#!/bin/bash

# Kubectl client aliases for faster experience

# aliases

alias k="kubectl"
alias kd="kubectl describe"
alias kswitch='kubectl config use-context'


# Global variables

ALL_PODS=()
SELECTED_PODS=()
SELECTED_POD_NUM=1


# Inner functions

_get_matched_names () {
    local names match_name
    match_name=$1
    shift;
    names=("$@")
    SELECTED_PODS=()
    for name in $names; do
	if [[ ${name} == ${match_name}* ]]; then
	     SELECTED_PODS+=($name)
	fi
    done
}

_get_random_number () {
    local limit_num 
    limit_num=$1
    SELECTED_POD_NUM=$(( ( RANDOM % $limit_num ) + 1 ))
}

_select_pods_by_name () {
    ALL_PODS=($(kubectl get pods --output=jsonpath='{.items[*].metadata.name}'))
    SELECTED_PODS=()
    _get_matched_names $1 $ALL_PODS
}


# Commnads

ke () {
    _select_pods_by_name $1
    local number_of_selected_pods
    number_of_selected_pods=${#SELECTED_PODS[@]}
    SELECTED_POD_NUM=1
    _get_random_number $number_of_selected_pods
    echo "Selected pod: ${SELECTED_PODS[$SELECTED_POD_NUM]}" 
    kubectl exec -it "${SELECTED_PODS[$SELECTED_POD_NUM]}" bash
}

klogs () {
    _select_pods_by_name $1
    shift
    for pod in $SELECTED_PODS; do
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
        echo "\\n\\n\\n====================== $pod =========================\\n\\n\\n"
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
        kubectl logs "$pod" $* --follow=false;
    done
}

