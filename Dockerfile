FROM ethereum/client-go

EXPOSE 8546
EXPOSE 8545

ENTRYPOINT ["geth"]
CMD ["--rinkeby", "--ws", "--wsaddr", "0.0.0.0", "--wsport", "8546", "--wsorigins", "*", "--datadir", "/.rinkeby", "--cache", "512", "--rpc", "--rpcapi", "personal,eth,network", "--rpcaddr", "0.0.0.0", "--rpcport", "8545", "--fast", "--bootnodes", "enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303"]
