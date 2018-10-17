FROM eosbuilder as builder

ARG tag=v1.1.0

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ssh && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/.ssh && chmod 755 /root/.ssh

RUN git clone https://github.com/eosforce/eosforce --recursive \
    && cd eosforce && git submodule update --init --recursive \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true \
    && cmake --build /tmp/build --target install


FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY --from=builder /tmp/build/bin /opt/eosio/bin
COPY --from=builder /tmp/build/contracts  /tmp/contracts
COPY nodeosd.sh /opt/eosio/bin/nodeosd.sh
COPY config.ini /
COPY genesis.json /
COPY System.abi /
COPY System.wasm /
COPY System01.abi /
COPY System01.wasm /
COPY eosio.token.abi /
COPY eosio.token.wasm /
COPY eosio.bios.abi /
COPY eosio.bios.wasm /
COPY eosio.msig.abi /
COPY eosio.msig.wasm /
ENV EOSIO_ROOT=/opt/eosio
RUN chmod +x /opt/eosio/bin/nodeosd.sh
ENV LD_LIBRARY_PATH /usr/local/lib
VOLUME /opt/eosio/bin/data-dir
ENV PATH /opt/eosio/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
