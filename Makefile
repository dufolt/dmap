all:; \
	cp src/context.json dist/context.json; \
	cd src/sol; \
		solc \
		--optimize \
		--pretty-json \
		--combined-json bin,bin-runtime,abi \
		--overwrite \
		-o ../../dist \
		{dmap,xreg}.sol
