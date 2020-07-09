#! /usr/bin/env bash
function grant(){
    echo "realizando coneção ao banco $3 
    executando a query:
        $2 TO '$1'"
    mysql --login-path=local -D $3 -e "$2 TO '$1'@'$4';"
    echo "Query executada com sucesso!"
}

function revoke(){
    echo "realizando coneção ao banco $3 
    executando a query:
    $2 FROM '$1'"
    mysql --login-path=local -D $3 -e "$2 FROM '$1'@'$4';"
    echo "Query executada com sucesso!"
}
function operacao(){

    mysql --login-path=local -D $1 -e "$2"
    
}

while getopts ":u: G: R: h: d: e:" opt; 
do
    case $opt in
        "u") 
            name=$OPTARG
        ;;
        "G") 
            gran=$OPTARG
            grant $name "$gran" $data $host
        ;;
        "R")
            revo=$OPTARG
            revoke $name "$revo" $data $host
        ;;
        "h")
            host=$OPTARG
        ;;
        "d")
            data=$OPTARG
        ;;
        "e")
            ope=$OPTARG
            operacao $data "$ope"
        ;;
        "?") echo "-$OPTAGR é uma opção inválida"
        ;;
        ":") echo "opção inválida: -$OPTARG requer um argumento"
        ;;
    esac
done
shift $((OPTIND -1))

