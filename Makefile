all:; \
	solc \
	--optimize \
	--pretty-json \
	--combined-json bin,bin-runtime,abi \
	--overwrite \
	/=/ \
	-o .evm \
	sol/{dmap,dmap2,wrap,xreg,quickstart}.sol \
;

publish:; npm shrinkwrap;
