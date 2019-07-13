let abi = require("./dmap-abi.js");
module.exports = {
    context: {
        relative: '0x20d20820f5d4D310281533CD9154C1bE22D6e195' 
      , bootstrap: "https://mainnet.infura.io/v3/c8a1aae584be4a4b836963c241fc752c"
    }
  , abi: {
        dmap: JSON.parse(abi.dmap.abi)
     ,  xreg: JSON.parse(abi.xreg.abi)
  }
  , ZERO_ADDRESS: '0x0000000000000000000000000000000000000000'
  , ZERO_BYTES32: '0x0000000000000000000000000000000000000000000000000000000000000000'
}
