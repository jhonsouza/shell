#! /usr/bin/env bash
 function controle(){
    crontab -u jhonatan cron.txt
    ssh -l jhon 192.168.0.101 "ps -aux > processos.log"     
    scp jhon@192.168.0.101:/home/jhon/processos.log $1  
 }


while getopts ":l:" opt;
do
    case $opt in
        "l") 
            var=$2
            echo "os logs foram extraidos em $2"
        ;;
        "?") echo "-$OPTAGR é uma opção inválida, consulte -h"
        ;;
        ":") echo "opção inválida: -$OPTARG requer um argumento"
        ;;
    esac 
done
shift $((OPTIND -1))
controle $var 
