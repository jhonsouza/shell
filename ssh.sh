#! /usr/bin/env bash
function usage() {
    echo "usage: ssh.sh [OPTIONS] COMMAND"
    echo "Options:
            -u | --usuário   nome do usário"
}
function ssh_connect() {
    echo "conectando ao servidor"
    ssh -l $1 192.168.0.114
    
}
while getopts ":h u:" opt; 
do
    case $opt in
        "h") usage
        ;;
        "u") 
            name=$2
            ssh_connect $name
        ;;
        "?") echo "-$OPTAGR é uma opção inválida, consulte -h"
        ;;
        ":") echo "opção inválida: -$OPTARG requer um argumento"
        ;;
    esac
done
shift $((OPTIND -1))
 