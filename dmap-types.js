let artifacts = require("./evm/combined.json").contracts;

for( key in artifacts) {
    var name = key.split(":");
    module.exports[name[1]] = artifacts[key];
}

// Aliases
module.exports.dmap = module.exports.DMap
