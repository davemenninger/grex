defmodule Grex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :grex,
      version: "0.0.1",
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  def application do
    [
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:credo, "~> 1.1"},
      {:httpotion, "~> 3.1"},
      {:exactor, "~> 2.2"},
      {:mock, "~> 0.3.3"}
    ]
  end
end
