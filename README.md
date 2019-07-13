`dmap`
===

`dmap` is a universal namespace defined in terms of the Ethereum chain state.
`dpath` is the path format and traversal language used by `dmap`. It is designed to be future-proof and extensible.
`dmap` develops in an ad-hoc manner over time, and knowledge about the structure of the dmap makes its way into clients as optimizations and sometimes language extensions after real use cases motivate them.

This repo contains a reference implementation of `dmap` in JavaScript.

agenda
---

* `dmap abi` by address
* `.` rune
* `:` rune
* source bootstrap (git hash on chain, `dmap update` verifies it before linking)
* `^` rune

sample (real) paths
---

```
.      the dmap
.b.    owned by Mr. B's
.b^    Mr. B's
.x:    xreg, the worst registry
:x:    implicit locks made explicit
.x:b   `.b`
```

