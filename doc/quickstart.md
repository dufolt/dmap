```
dmap-bin DMap3
# Deploy this bytecode
dmap-abi DMap3
# Use this ABI to interact with it

dmap-abi XReg
# Use this ABI to interact with the registry for .x.
dmap .x.reg.
# This is the address of the registrar contract

# `XReg.newChild` creates a DMap1, you probably don't want this
# `XReg.register` takes any value - like your fresh DMap3
# Both are permanent! Be careful!
```
