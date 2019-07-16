`dmap .x.<yourname>.`
===

*Note: `dmap` is a read-only utility. It might eventually go as far as generating unsigned
transactions, but it will always delegate key management to another tool (e.g. `ethsign`). We included screenshots of MyEtherWallet.*

### 1) Call `createChild(bytes32 name)` on the `xreg` contract

```
dmap .x.reg.
# Note this address
dmap type-abi XReg
# Note this ABI
```

For convenience, the registrar is itself registered at `.x.reg.`

*Warning: `.x.` values are immutable. If you register a dmap at `.x.ample.`, you will be able to update `.x.ample.subname.`, but `.x.ample.` will always return the dmap you just registered.*

IMG

*Note: DMaps accept any bytes32 as a key, but not all keys are queryable by `dmap`. Stand by for documentation about the `dpath` format/language. For now, stick with lowercase letters and numbers (that is, ascii-encoded, left-aligned (most significant byte first)).*

*Note: You can use `.x.` to store arbitrary values, including existing DMaps, by using `register(key, value)`. In this guide we assumed you will want to register a fresh DMap so you can write to its subpaths.*

### 2) Write to your DMap with `setValue(bytes32 key)`

```
dmap type-abi DMap
```

IMG

### 3) Standalone DMaps

```
dmap type-bin DMap
```

You don't need to use a particular contract to join the dmap system. You can
deploy a DMap directly, or anything else that implements `getValue(bytes32)`.

You can begin a query at any address using the "relative" flag (`-r`):

```
dmap .myKey. -r 0x...<yourDMapAddress>
```

You can point a key to another DMap to get subpaths

`# In a wallet:  yourDMap.setValue("subKey", subMapAddress)`

```
dmap .myKey.subKey. -r 0x...<yourDMapAddress>
```

Finally, you can register it with `.x.`. Remember, you don't `setValue` on `.x.`, you
`register` on `.x.reg.`.

`# In a wallet: xreg.register(yourname, yourDMapAddress)`

`dmap .yourname.myKey.subKey.`
