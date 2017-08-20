defmodule Communications.Mixfile do
  use Mix.Project

  def project do
    [
      app: :communications,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ecto, :postgrex],
      mod: {Communications.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ecto, "~> 2.0"},
     {:postgrex, "~> 0.11"}]
  end
end
