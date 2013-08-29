defmodule Grex.Mixfile do
  use Mix.Project

  def project do
    [ app: :grex,
      version: "0.0.1",
      elixir: "~> 0.10.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:httpotion, github: "myfreeweb/httpotion"},
     {:exactor,   github: "sasa1977/exactor"},
     {:mock,      github: "jjh42/mock"}]
  end
end
