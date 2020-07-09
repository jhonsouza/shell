#! /usr/bin/env bash

function ssh_connect() {
    echo "Concetando ao servidor"
    sshpass -p "$2" ssh $1@192.168.0.114   
}
while getopts ":u: s:" opt; 
do
    case $opt in
        "u") 
            name=$OPTARG
        ;;
        "s") 
            senha=$OPTARG  
        ;;
        "?") echo "-$OPTAGR é uma opção inválida, consulte -h"
        ;;
        ":") echo "opção inválida: -$OPTARG requer um argumento"
        ;;
    esac
done
shift $((OPTIND -1))
ssh_connect $name $senha