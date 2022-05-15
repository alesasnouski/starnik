defmodule Starnik.MixProject do
  use Mix.Project

  def project do
    [
      app: :starnik,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Starnik.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.3"},
      {:timex, "~> 3.7.5"},
      {:ecto, "~> 3.8"},
      {:ecto_sql, "~> 3.8"},
      {:postgrex, "~> 0.16"},
      {:absinthe_plug, "~> 1.5"},
      {:dataloader, "~> 1.0"},
      {:plug, "~> 1.13"},
      {:absinthe, "~> 1.7"},
      {:exsync, "~> 0.2", only: [:dev]},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:plug_cowboy, "~> 2.5"},
      {:flex_logger, "~>0.2.1"},
      {:telemetry, "~> 1.0"}
    ]
  end
end
