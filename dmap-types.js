let artifacts = require("./evm/combined.json").contracts;

for( key in artifacts) {
    var name = key.split(":");
    module.exports[name[1]] = artifacts[key];
    module.exports[name[1]].abi = JSON.parse(artifacts[key].abi);
}

// Aliases
module.exports.dmap = module.exports.DMap
module.exports.quickstart = module.exports.QuickStart
module.exports.dwrap = module.exports.DWrap
