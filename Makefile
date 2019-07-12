all: dmap xreg

dmap :; solc --optimize --pretty-json --combined-json bin,abi src/dmap.sol > dist/dmap.json
xreg:; solc --optimize --pretty-json --combined-json bin,abi src/xreg.sol > dist/xreg.json
