#!/bin/ash

set -e
if [[ -z "${USUARIO}" ]]; then
  echo "USUARIO no definido"
  exit 1
elif [[ -z "${PASSWORD}" ]]; then
  echo "PASSWORD no definida"
  exit 1
elif [[ -z "${CUENTA}" ]]; then
  echo "CUENTA no definida"
  exit 1
elif [[ -z "${DOMINIO}" ]]; then
  echo "DOMINIO no definido"
  exit 1
elif [[ -z "${ZONAS}" ]]; then
  echo "ZONAS no definidas"
  exit 1
fi

: COMPROBAR_CADA=${COMPROBAR_CADA:-10}

# $ZONAS es una variable con las zonas separadas por comas
INPUTS=$(echo -n "${ZONAS}" | jq -Rsc 'split(",")')
jq -Rn --arg cuenta "${CUENTA}" --argjson comprobar_cada "${COMPROBAR_CADA:=10}" --arg dominio "${DOMINIO}" --argjson inputs "${INPUTS}" ' $inputs | {$cuenta, $comprobar_cada, zonas: {($dominio): .} }' > /etc/dinaip.conf

alias dina='dinaip -u "${USUARIO}" -p "${PASSWORD}"'
# dinaip -u "${USUARIO}" -p "${PASSWORD}" -a rubencabrera.es:www
# echo "-i"
dina -i
# echo "Añadiendo zona www"
# echo "-l Lista los dominios de esta cuenta"
# dina -l
# sleep 5
# echo "-s Muestra el estado"
# dina -s
# Para meter otra zona este es el comando.
# TODO: ejecutar opcionalmente si le pasamos los argumentos necesarios
# echo "Vamos a meter otra zona NUEVA"
# dina -a rubencabrera.art:prueba
# echo "Fin del script, hasta luego"
sleep 300
