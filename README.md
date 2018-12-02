# geth-rinkeby-docker

> Run a [geth](https://github.com/ethereum/go-ethereum) node that syncs up with [rinkeby](https://www.rinkeby.io/) testnet in a [Docker](https://www.docker.com/) container.

# Usage


### Docker

```bash
docker-compose up
```

### Kubernetes (minikube)


```bash

kubectl create -f ./kubernetes/geth-deployment.yaml 
kubectl create -f ./kubernetes/geth-service.yaml 

```

## Ports

RPC URL

```
http://{docker_ip}:8545/
```

WebSocket URL

```
ws://{docker_ip}:8546/
```

## Running in EC2

Make sure to select an instance type with enough memory.

Install and run instructions:

```bash
sudo yum update -y
sudo yum install -y docker
sudo yum install -y git
curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > ./docker-compose
sudo mv ./docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker-compose up --build -d
```

Check syncing status:

```bash
sudo docker exec -it {container_id} geth attach ipc:/.rinkeby/geth.ipc

> eth.syncing
{
  currentBlock: 405371,
  highestBlock: 837461,
  knownStates: 272806,
  pulledStates: 269942,
  startingBlock: 271758
}
```

Edit the EC2 instance security group inbound rules to allow ports `8545` and `8546`.

# FAQ

- Q. When running `docker-compose up`, I'm getting a `BAD BLOCK` error!

  ```bash
  geth_1  | ########## BAD BLOCK #########
  geth_1  | Chain config: {ChainID: 4 Homestead: 1 DAO: <nil> DAOSupport: true EIP150: 2 EIP155: 3 EIP158: 3 Metropolis: 9223372036854775807 Engine: clique}
  geth_1  |
  geth_1  | Number: 1035301
  geth_1  | Hash: 0x9e673f84fa096626d50440cbb7c71ec891fd42993be3d99f87c826b43842c592
  geth_1  |       receipt{med=a95f1fbd2fa6589acd708d187dfefab5944c64f5eb8eec1c32eb73a8d36a8b88 cgas=27183 bloom=00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 logs=[]}
  geth_1  |
  geth_1  |
  geth_1  | Error: invalid receipt root hash (remote: 85f374e1457eb09d56bf61c66cc7222a7e88167919d5574d3c
  ```

  - A. Try removing `--bootnodes` and `--fast` options. Also try running with `sudo`.

# License

MIT
