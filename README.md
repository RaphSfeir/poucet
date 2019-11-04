# Poucet

**Very simple tool to get the final destination of a potential redirects URL. Based on HTTPotion.**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `poucet` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:poucet, "~> 0.1.0"}
  ]
end
```
## Usage

```elixir
iex> Poucet.final_location("https://t.co/2m6SRbn6or")
{:ok,
 "https://www.eurogamer.net/articles/2019-11-04-londons-pokemon-center-is-running-out-of-its-exclusive-top-hat-pikachus"}

iex> Poucet.final_location("https://github.com/404")
{:error, 404}

```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/poucet](https://hexdocs.pm/poucet).

