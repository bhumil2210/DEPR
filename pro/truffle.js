module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

    networks: {
  	development: {
  		host: "192.168.43.165",
  		port: "22001",
  		network_id: "*",
  		gas: "4700000",
  		gasPrice: "0"
  	}
  }

};
