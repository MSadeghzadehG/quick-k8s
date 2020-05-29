#!/bin/bash

# Kubectl client aliases for faster experience

# aliases

alias k="kubectl"
alias kd="kubectl describe"
alias kswitch='kubectl config use-context'


# Global variables

K_GET_NAMES=()
SELECTED_PODS=()
SELECTED_POD_NUM=1
K8S_BACKUP_DIR=~/.k8s_backups
COMMANDS=(ke klogs kbackup)

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

_get_type_names_list () {
    local k_type
    k_type=$1
    K_GET_NAMES=($(kubectl get "$k_type" --output=jsonpath='{.items[*].metadata.name}'))
}

_select_pods_by_name () {
    _get_type_names_list pods
    SELECTED_PODS=()
    _get_matched_names $1 $K_GET_NAMES
}

_complete_function () {
    local cmd out cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    cmd="${1##*/}"
    case "$cmd" in
    ke | klogs)
	_get_type_names_list pods
    	out=("${K_GET_NAMES[@]}")
	;;
    kbackup)
	case "$COMP_CWORD" in
	1)
	    out=($(kubectl api-resources --output=name))
	    ;;
        2)        
	    out=(json yaml wide custom)
	    ;;
	esac
	;;
    esac
    COMPREPLY=("${out[@]}")
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

kbackup () {
    local k_type date dir output_format file_name
    k_type=$1
    output_format=${2:=yaml}
    date=$(date '+%Y-%m-%d')
    dir="$K8S_BACKUP_DIR/$date-$k_type"
    mkdir -p $K8S_BACKUP_DIR $dir
    _get_type_names_list $k_type
    for name in $K_GET_NAMES; do
        file_name="$dir/$name.backup"
	kubectl get "$k_type" "$name" -o "$output_format" >> "$file_name"  
	echo "$name Done."
    done
    echo "The backup procedure was done successfully."
}

for name in $COMMANDS; do
    complete -F _complete_function "$name"
done
