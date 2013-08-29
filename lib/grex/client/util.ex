defmodule Grex.Client.Util do

  @base "http://www.goodreads.com"

  defp body(response),   do: response.body
  defp parse(body),      do: body |> XmlNode.from_string
  defp uri(path, query), do: "#{@base}/#{path}.xml?#{URI.encode_query(query)}"

  def get(path, query // []) do
    uri(path, query) |> HTTPotion.get |> body |> parse
  end
  
end