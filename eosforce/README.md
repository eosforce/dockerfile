# EOSForce Docker Image

* genesis config: <https://github.com/chainpool/genesis>

## Docker RUN

### eosio 启动节点

```
mkdir -p /data/eosio
mkdir -p /data/nodeos/eosio
```

```
docker run -d --restart=always --name eosio -v ~/data/eosio:/opt/eosio/bin/data-dir -v ~/data/nodeos/eosio:/root/.local/share/eosio/nodeos -p 8888:8888 -p 9876:9876 akagi201/eosforce nodeosd.sh
```

#### 上传系统合约
* cleos 命令: `docker exec eosio cleos -h`
* 创建 walllet: `docker exec eosio cleos wallet create`
* 导入私钥: `docker exec eosio cleos wallet import <biosbpa active private key>`
* 合约目录: `docker exec eosio cleos set contract eosio contracts/System -p biosbpa`

### bios 出块节点

```
mkdir -p /data/biosbp{xxx}
mkdir -p /data/nodeos/biosbp{xxx}
```

```
docker run -d --restart=always --name bpa -v /data/biosbp{xxx}:/opt/eosio/bin/data-dir -v /data/nodeos/biosbp{xxx}:/root/.local/share/eosio/nodeos -p 8889:8888 -p 9877:9876 akagi201/eosforce nodeosd.sh
```
