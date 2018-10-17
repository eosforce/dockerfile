#!/bin/sh
cd /opt/eosio/bin

if [ -f '/opt/eosio/bin/data-dir/genesis.json' ]; then
    echo
  else
    cp /genesis.json /opt/eosio/bin/data-dir
fi

if [ -f '/opt/eosio/bin/data-dir/System01.wasm' ]; then
    echo
  else
    cp /System01.wasm /opt/eosio/bin/data-dir
fi

if [ -f '/opt/eosio/bin/data-dir/System01.abi' ]; then
    echo
  else
    cp /System01.abi /opt/eosio/bin/data-dir
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
