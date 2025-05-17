# statisaur
Elixir library for doing univariate statistics and certain analyses.

[![CircleCI](https://circleci.com/gh/crertel/statisaur/tree/master.svg?style=svg)](https://circleci.com/gh/crertel/statisaur/tree/master)
[![hex.pm version](https://img.shields.io/hexpm/v/statisaur.svg)](https://hex.pm/packages/statisaur)
[![hex.pm downloads](https://img.shields.io/hexpm/dt/statisaur.svg)](https://hex.pm/packages/statisaur)
[![Coverage Status](https://coveralls.io/repos/github/crertel/statisaur/badge.svg?branch=master)](https://coveralls.io/github/crertel/statisaur?branch=master)

What is statisaur?
===================

Statisaur is a library for handling common univariate and descriptive statistics, as well as certain analyses, regressions, and tests.

Features
========

TBD.

Installation
============

This package is available from the [hex](https://hex.pm) package manager.

Just add it to your `mix.exs` file like so:

```
  def project do
    [app: myapp,
     version: "x.y.z",
     elixir: "~> 1.0",
     description: "description",
     package: ...,
     deps: [
        ...,
        {:statisaur, "~> 0.1.0" },
        ...
        ] ]
  end
```

Conventions in library
======================

All operations are accompanied by tests and documentation.

Contributing
============

### Issues

1. Open an issue on Github.

### For developers

1. Fork this project on Github.

2. Open an issue for your proposed changes.

3. Add tests for your new functionality, if applicable.

4. Add documentation for your functionality, if applicable. *NO DOCS -> NO MERGE*.

5. Submit a pull request.

6. Bask in the glory of having helped create content on one of the best platforms ever devised.

### Local development with Nix

If you have [Nix](https://nixos.org/) and flakes enabled, you can enter a shell
with all required dependencies via:

```shell
nix develop
```

This provides Elixir, Erlang and tooling for running the project locally.

### For non-developers

1. Buy us a beer if you see me at ElixirConf.

Wishlist
========

TBD.

License
=======

This project is put into the public domain under the unlicense.

If you can't use that, consider it under the WTFPL.

If you can't use *that*, fine--use the new BSD license.

Contributors
=============
* Chris Ertel
* Amanda Shih
* Geoff Smith
* Neeraj Tandon

