all:; \
	solc \
	--optimize \
	--pretty-json \
	--combined-json bin,bin-runtime,abi \
	--overwrite \
	/=/ \
	-o .evm \
	sol/{dmap,dmap2,xreg,wrap,quickstart}.sol; \
	npm shrinkwrap;
