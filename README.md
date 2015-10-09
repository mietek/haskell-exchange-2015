_haskell-exchange-2015_
=======================

Materials for my [Haskell eXchange 2015](https://skillsmatter.com/conferences/7069-haskell-exchange-2015) talk.

See [_formal-logic_](https://github.com/mietek/formal-logic) for more formalisations.


Usage
-----

To check all files automatically:

```
$ make
```

To load a particular file for interactive use:

```
$ agda --safe -I -i src src/FILE.agda
```

```
$ ghci -Wall -isrc src/FILE.hs
```

```
$ idris -i src src/FILE.idr
```

Tested with Agda 2.4.2.3, Idris 0.9.19, and GHC 7.8.4.


About
-----

Made by [Miëtek Bak](https://mietek.io/).  Published under the [MIT X11 license](LICENSE.md).
