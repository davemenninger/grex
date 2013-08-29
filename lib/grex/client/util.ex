defmodule Grex.Client.Util do

  @base "http://www.goodreads.com"

  defp body(record),     do: record.body
  defp parse(body),      do: body |> :erlsom.simple_form
  defp uri(path, query), do: "#{@base}/#{path}.xml?#{URI.encode_query(query)}"

  def get(path, query // []) do
    uri(path, query) |> HTTPotion.get |> body |> XmlNode.from_string
  end
  
end