#! /usr/bin/env bash

function ssh_connect() {
    sshpass -p "$2" ssh $1@192.168.43.98     
}
while getopts ":u: s:" opt; 
do
    case $opt in
        "u") 
            name=$2
        ;;
        "s") 
            senha=$4
        ;;
        "?") echo "-$OPTAGR é uma opção inválida, consulte -h"
        ;;
        ":") echo "opção inválida: -$OPTARG requer um argumento"
        ;;
    esac
done
shift $((OPTIND -1))
ssh_connect $name $senha