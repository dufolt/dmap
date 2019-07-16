`dmap`
===

* `dmap` is a universal namespace defined by part of the Ethereum chain state.
* `dmap <dpath>` gets the 32-byte value at the given path.
* `dpath` is the path format and mini-language used by `dmap`.
* `dpath` is future-proof and extensible.

Try it now:
---
```
npm install -g dmap-cmd

dmap .x.ample.        # Query
dmap walk .x.ample.   # Details
```

### [Quickstart on `.x.`: `dmap .x.yourName.`](https://github.com/dufolt/dmap/blob/master/doc/quickstart.md)

If you want a valuable name, you should make a valuable namespace.

Use Cases
---

`dmap` should be immediately useful for:

* Package distribution (verification)
* GUI distribution (verification)
* Key signing / WoT bootstrapping

Any time you sign an update to a "named something", you could be signing it with a multisig or any other smart contract.

Examples
---
```
> dmap .x.
0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d

> dmap .x.ample.
0xdbb5fbdfdf8f2f87f94f28cbd3cacf3ad28cfda6

> dmap walk .x.ample.
walk .x.ample.
step .x.ample.
step read .x.ample.
step read -r 0x20d20820f5d4D310281533CD9154C1bE22D6e195 .x.ample.
     0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d000000000000000000000000
step read -r 0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d .ample.
     0xdbb5fbdfdf8f2f87f94f28cbd3cacf3ad28cfda6000000000000000000000000
step read -r 0xdbb5fbdfdf8f2f87f94f28cbd3cacf3ad28cfda6 .
DONE 0xdbb5fbdfdf8f2f87f94f28cbd3cacf3ad28cfda6
```

Example paths to study
---

Active
```
.             the dmap
.d.           the dmap
.x.           xreg, the worst registry (is DMap, owner is XReg)
.x.ample.     example paths for docs
.x.dmap.      the dmap
```

Future
```
:x:ample:definitly-locked  
:x:ample.possibly-mutable 
.x.ample#ipld
.x.foo@.
.x.foo@@@.
.x.foo%bar.
```
Development Notes
---

* Version 0.0.x has an unstable API. Version 0.1.0 will have a stable `get` and `walk` API for paths containing only `.` runes (separators).
* `dmap` command line commands define a query language. `dmap` libraries should implement `dmap("walk .x.ample.path").` first and `.walk(path)` helper methods second.
* We expect other implementations to be forks of Ethereum light clients optimized for dmap queries.

```
git clone https://github.com/dufolt/dmap
cd dmap
make
```
or
```
git clone keybase://team/dmap/dmap
cd dmap
make
```



Agenda
---

* `dmap type-info` by path, by address
* `.` rune
* `:` rune
* source bootstrap (git hash on chain, `dmap update` verifies it before linking)
* `^` rune


