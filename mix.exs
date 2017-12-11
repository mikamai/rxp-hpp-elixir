defmodule RxpHppElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rxp_hpp_elixir,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:timex, "~> 3.1"},
      {:secure_random, "~> 0.5"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:poison, "~> 3.1"}
    ]
  end
end
