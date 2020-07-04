#! /usr/bin/env bash 

#autor: Jhonatan Souza
THIS=$(basename $0)
package=""
linha=0
nomes=""
function usage() {
    echo "usage: users.sh [OPTIONS] COMMAND"
    echo "Options:
            -f | --file      Ler um aquivo de texto <file.type>
            -c | --create    Cria novos usuários 
            -a | --alter     Alterar permissões de usuário
            -b | --block     Bloquear acesso do usuário 
            -d | --unlock    Desbloqueia acesso do usuário"
}
function read_csv() {
    sed -i 1d $1
    while IFS=',' read nome senha
    do
        echo "$nome" >> nomes.txt
        ((linha=$linha+1))
    done < "$1" 
    echo "foram carregados $linha usuários"
}

function create_usrs() {
    while IFS="," read name_user senha nome sala fonet foner outro 
    do
        sudo adduser $name_user --force-badname -q --gecos  "$nome,$sala,$fonet,$foner,$outro" --disabled-password
        echo "$name_user:$senha" | sudo chpasswd
    done < "$1"
        echo "$linha usuários foram criados com SUCESSO!"
}
function bloquear_user(){
    while read nome
    do
       sudo usermod -L $nome 
    done < "$1"
        echo "$linha usuários foram bloqueados com SUCESSO!"
}

function desbloquear_user(){
     while read nome
    do
        sudo usermod -U $nome
    done < "$1"
        echo "$linha usuários foram desbloqueados com SUCESSO!"
}
while getopts ":h f: c b d" OPT; 
do
    case $OPT in
        "h") usage
        ;;
        "f") 
            echo "lendo o arquivo $2"
            arq=$2
            rm nomes.txt
            cat $arq > usr.txt
            read_csv usr.txt
            package=usr.txt
        ;;
        "c") 
            echo "iniciando criação de usuários"
            create_usrs $package 
        ;;
        "b")
            nomes=nomes.txt
            echo "bloqueando usuários da lista"
            bloquear_user $nomes
        ;;
        "d")
            nomes=nomes.txt
            echo "desbloqueando usuários da lista"
            desbloquear_user $nomes
        ;;
        "?") echo "opção inválida, consulte -h"
        ;;
    esac
done
shift $((OPTIND -1))
