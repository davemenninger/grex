defmodule Grex.API.Pagination do

  require Record
  Record.defrecord :pager, foo: "", total: 0, page: nil
  Record.defrecord :page, start_item: 0, end_item: 0, items: []

  @moduledoc """
  Wrap 
  """

  defp count(node, attr) do
    case node |> XmlNode.attr(attr) |> String.to_integer do
      i -> i
    end
  end

  @doc """
  Parse an XML node for pagination attributes, transform child nodes
  using a provided function, and wrap the results in a Pager and 
  Page records.
  """
  def build(node, _func) do
    pager(
      total: count(node, :total),
      page: page(
        start_item: count(node, :start),
        end_item:   count(node, :end),
      items:      XmlNode.all(node, "/*/*")
    )
    )
  end

end

# TODO: Instead of holding onto a single page, keep multiple pages
#       and a function to request data for new pages

# So we can iterate over items in a page
defimpl Enumerable, for: Grex.API.Pagination.Page do
  def count(page) do
    Enum.count(page.items)
  end 
 
  def member?(page, value) do
    page.items.member(value)
  end
 
  def reduce(page, acc, fun) do
    Enum.reduce(page.items, acc, fun)
  end
end
