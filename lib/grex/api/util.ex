defmodule Grex.API.Util do

  @doc "Convert a string value to a boolean"
  defp bool("true"),  do: true
  defp bool("false"), do: false
  defp bool(other),   do: false

  @doc "Convert a string value to an integer"
  defp int(str) do
    case str |> String.to_integer do
      i -> i
    end
  end

  @doc "Extract the text from a node"
  defp text(node), do: node |> XmlNode.text

  @doc "Extract an attribute from a node"
  defp attr(node, name), do: node |> XmlNode.attr(name)

  @doc "If the value of a node is nil"
  defp is_nil_node?(node) do
    case attr(node, "nil") do
      "true" -> true
      _      -> false
    end
  end

  @doc "Extract the value from a node"
  defp value(node) do
    if is_nil_node?(node) do
      nil
    else
      case attr(node, "type") do
        "boolean" -> node |> text |> bool
        "integer" -> node |> text |> int
        other     -> node |> text
      end
    end
  end

  @doc "Extract the value from a node by name"
  def value(node, name) do
    node |> XmlNode.first("/user_shelf/#{name}") |> value
  end

end
