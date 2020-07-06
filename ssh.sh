#! /usr/bin/env bash

function ssh_connect() {
    ssh -l $1 192.168.43.19
    
}
while getopts ":u:" opt; 
do
    case $opt in
        "u") 
            name=$2
        ;;
        "?") echo "-$OPTAGR é uma opção inválida, consulte -h"
        ;;
        ":") echo "opção inválida: -$OPTARG requer um argumento"
        ;;
    esac
done
shift $((OPTIND -1))
ssh_connect $name 