let artifacts = require("../evm/combined.json").contracts;

for( key in artifacts) {
    var name = key.split(":");
    module.exports[name[1]] = artifacts[key];
    module.exports[name[1]].abi = JSON.parse(artifacts[key].abi);
}
