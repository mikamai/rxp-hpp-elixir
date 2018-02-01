defmodule RxpHpp.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rxp_hpp_elixir,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package()
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

  defp description do
    "Elixir SDK to encrypt / decrypt Realex HPP requests and responses."
  end

  defp package do
    [
      name: "rxp_hpp",
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Alberto Pellizzon"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/apellizzn/rxp-hpp-elixir"}
    ]
  end
end
