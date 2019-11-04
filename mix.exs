defmodule Poucet.MixProject do
  use Mix.Project

  def project do
    [
      app: :poucet,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      name: "Petit Poucet",
      source_url: "https://github.com/RaphSfeir/poucet",
      homepage_url: "https://github.com/RaphSfeir/poucet",
      docs: [
        main: "Poucet",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Very simple tool to get the final destination of a potential redirects URL."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "Github Page" => "https://github.com/RaphSfeir/poucet"
      }
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    ]
  end
end
