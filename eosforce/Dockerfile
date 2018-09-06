FROM akagi201/eosbuilder as builder

ARG tag=v0.7

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ssh && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/.ssh && chmod 755 /root/.ssh
ADD id_rsa_eosforceio /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config
RUN echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config

RUN git clone https://github.com/eosforce/eosforce --recursive \
    && cd eosforce && git fetch -p && git checkout v1.0.1  \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build  -DSecp256k1_ROOT_DIR=/usr/local -DBUILD_MONGO_DB_PLUGIN=true \
    && cmake --build /tmp/build --target install


FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY --from=builder /tmp/build/bin /opt/eosio/bin
COPY nodeosd.sh /opt/eosio/bin/nodeosd.sh
COPY config.ini /
COPY genesis.json /
COPY System.abi /
COPY System.wasm /
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
