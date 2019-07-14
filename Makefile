all:; \
	cd sol; \
		solc \
		--optimize \
		--pretty-json \
		--combined-json bin,bin-runtime,abi \
		--overwrite \
		-o ../evm \
		{dmap,xreg,wrap,quickstart}.sol; \
	npm shrinkwrap;
