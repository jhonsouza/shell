#! /usr/bin/env bash 

#autor: Jhonatan Souza
THIS=$(basename $0)
package=""
linha=0

function usage() {
    echo "usage: users.sh [OPTIONS] COMMAND"
    echo "Options:
            -f | --file      Ler um aquivo de texto <file.type>
            -c | --create    Cria novos usuários 
            -r | --remove    Remove usuários
            -a | --alter     Alterar permissões de usuário
            -b | --block     Bloquear acesso ao usuário "
}
function read_csv() {
    sed -i 1d $1
    while IFS=',' read nome senha
    do
        ((linha=$linha+1))
    done < "$1" 

    echo "foram carregados $linha usuários"
}

function create_usrs() {
    while IFS="," read name_user senha nome sala fonet foner outro ops
    do
        sudo adduser $name_user --force-badname
        
        
    done < "$1"
}


while getopts ":h :f: c" OPT; 
do
    case $OPT in
        "h") usage
        ;;
        "f") 
            echo "lendo o arquivo $2"
            arq=$2
            #rm usr.txt
            cat $arq > usr.txt
            read_csv usr.txt
            package=usr.txt
        ;;
        "c") 
            create_usrs $package
        ;;
        "?") echo "opção inválida, consulte -h"
        ;;
    esac
done
shift $((OPTIND -1))
