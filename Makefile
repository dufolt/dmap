all:; \
	cd sol; \
		solc \
		--optimize \
		--pretty-json \
		--combined-json bin,bin-runtime,abi \
		--overwrite \
		-o ../evm \
		{dmap,dmap2,xreg,wrap,quickstart}.sol; \
	npm shrinkwrap;
