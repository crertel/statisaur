# Contributor Guide

This project is an Elixir library. Development is easiest using the provided `flake.nix`.

## Development Environment

We recommend using **nix flakes**. With flakes enabled, run `nix develop` from the repo root to enter a shell with Elixir and its dependencies. All examples below assume you are in this development shell.

## Programmatic Checks

Before committing changes, run the following commands and ensure they pass:

```bash
mix format --check-formatted
mix test
```

You can execute them through `nix develop -c` if you are not already in the shell.

## Formatting

Apply formatting with `mix format`.


