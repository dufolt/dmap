`dmap`
===

`dmap` is a universal namespace defined in terms of the Ethereum chain state.
`dpath` is the path format and traversal language used by `dmap`. It is designed to be future-proof and extensible.
`dmap` develops in an ad-hoc manner over time, and knowledge about the structure of the dmap makes its way into clients as optimizations and sometimes language extensions after real use cases motivate them.

This repo contains a reference implementation of `dmap` in JavaScript.

Install
---
```
npm install -g dmap-cmd
```

Usage
---
```
> dmap .x.
0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d

> dmap get .x.
0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d

> dmap .x.dmap.
0x20d20820f5d4d310281533cd9154c1be22d6e195

> dmap walk .x.dmap.
walk .x.dmap.
step .x.dmap.
step .x.dmap. -r 0x20d20820f5d4D310281533CD9154C1bE22D6e195
  -> 0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d000000000000000000000000
step .dmap. -r 0x180513ff7459ebc79534d3cb8ac26a5a1ac8af0d
  -> 0x20d20820f5d4d310281533cd9154c1be22d6e195000000000000000000000000
step . -r 0x20d20820f5d4d310281533cd9154c1be22d6e195
DONE 0x20d20820f5d4d310281533cd9154c1be22d6e195
```

Example paths
---

```
.            the dmap
.b.          owned by Mr. B's
.b^          Mr. B's
.x:          xreg, the worst registry
:x:          implicit locks made explicit
.x:b         `.b`
```

Dev Install
---
```
git clone https://github.com/dufolt/dmap
cd dmap
npm install -g .
```
or
```
git clone keybase://team/dmap/dmap
cd dmap
npm install -g .
```

Agenda
---

* `dmap abi` by address
* `.` rune
* `:` rune
* source bootstrap (git hash on chain, `dmap update` verifies it before linking)
* `^` rune


