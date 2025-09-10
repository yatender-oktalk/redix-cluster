defmodule RedixCluster.Mixfile do
  use Mix.Project

  def project do
    [app: :redix_cluster,
     version: "0.0.2",
     elixir: "~> 1.12",
     start_permanent: Mix.env() == :prod,
     preferred_cli_env: [espec: :test],
     deps: deps(),
     description: description(), 
     package: package()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      mod: {RedixCluster, []},
      extra_applications: [:logger, :ssl, :crypto]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [ 
      {:redix, "~> 1.0"},
      {:poolboy, "~> 1.5"},
      {:crc, "~> 0.9"},
      # Development and test dependencies
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.25", only: :dev, runtime: false}, 
      {:espec, "~> 1.8", only: :test},
      # Benchmark dependencies
      {:benchfella, github: "alco/benchfella", only: :bench},
      {:eredis_cluster, github: "adrienmo/eredis_cluster", only: :bench}
    ]
  end

  defp description do 
    "A wrapper for redix to support cluster mode of redis"
  end

  defp package do
     [
       maintainers: ["zhongwencool", "masahiro tokioka", "tinglei8"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/tinglei8/redix-cluster.git"}
     ]
  end

end
