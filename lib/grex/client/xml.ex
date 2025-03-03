# https://gist.github.com/sasa1977/5967224
 
defmodule XmlNode do
  require Record

  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")

  def from_string(xml_string, options \\ [quiet: true]) do
    {doc, []} = 
      xml_string
      |> to_unicode_char_list
      |> :xmerl_scan.string(options)
 
    doc
  end
  
  def all(node, path) do
    for child_element <- xpath(node, path) do 
      child_element
    end
  end
 
  def first(node, path), do: node |> xpath(path) |> take_one
  defp take_one([head | _]), do: head
  defp take_one(_), do: nil
 
  def node_name(nil), do: nil
  def node_name(node), do: elem(node.element, 1)
 
  def attr(node, name), do: node |> xpath('./@#{name}') |> extract_attr
  defp extract_attr([xmlAttribute(value: value)]), do: to_unicode_string(value)
  defp extract_attr(_), do: nil
 
  def text(node), do: node |> xpath('./text()') |> extract_text
  defp extract_text([xmlText(value: value)]), do: to_unicode_string(value)
  defp extract_text(_), do: nil
  
  defp xpath(nil, _), do: []
  defp xpath(node, path) do
    :xmerl_xpath.string(to_charlist(path), node)
  end
 
  defp to_unicode_string(list) when is_list(list), do: :unicode.characters_to_binary(list)
  defp to_unicode_string(any), do: to_string(any)
 
  defp to_unicode_char_list(input) do
    input
    |> to_unicode_string
    |> to_charlist
  end
end
