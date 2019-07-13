all:; solc \
    --optimize \
    --pretty-json \
    --combined-json bin,bin-runtime,abi \
    --overwrite \
    -o dist \
    src/{dmap,xreg}.sol
