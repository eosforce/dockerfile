#!/bin/sh
cd /opt/eosio/bin

cp /genesis.json /opt/eosio/bin/data-dir
cp /System.wasm /opt/eosio/bin/data-dir
cp /System.abi /opt/eosio/bin/data-dir
cp /System01.wasm /opt/eosio/bin/data-dir
cp /System01.abi /opt/eosio/bin/data-dir
cp /eosio.token.wasm /opt/eosio/bin/data-dir
cp /eosio.token.abi /opt/eosio/bin/data-dir
cp /eosio.msig.wasm /opt/eosio/bin/data-dir
cp /eosio.msig.abi /opt/eosio/bin/data-dir
if [ -f '/opt/eosio/bin/data-dir/config.ini' ]; then
    echo
  else
    cp /config.ini /opt/eosio/bin/data-dir
fi


while :; do
    case $1 in
        --config-dir=?*)
            CONFIG_DIR=${1#*=}
            ;;
        *)
            break
    esac
    shift
done

if [ ! "$CONFIG_DIR" ]; then
    CONFIG_DIR="--config-dir=/opt/eosio/bin/data-dir"
else
    CONFIG_DIR=""
fi

exec /opt/eosio/bin/nodeos $CONFIG_DIR $@
