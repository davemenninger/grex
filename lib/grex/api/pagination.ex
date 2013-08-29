defmodule Grex.API.Pagination do
	@moduledoc """
  Wrap 
	"""

  defp count(node, attr) do
  	case node |> XmlNode.attr(attr) |> String.to_integer do
  		{i, ""} -> i
  	end
  end

  @doc """
  Parse an XML node for pagination attributes, transform child nodes
  using a provided function, and wrap the results in a Pager and 
  Page records.
  """
	def build(node, func) do
		alias Grex.API.Pagination.Pager, as: Pager
		alias Grex.API.Pagination.Page,  as: Page
		Pager.new(
			total: count(node, :total),
			page: Page.new(
				start_item: count(node, :start),
			  end_item:   count(node, :end),
				items:      Enum.map(XmlNode.all(node, "/*/*"), func)))
	end

end

# TODO: Instead of holding onto a single page, keep multiple pages
#       and a function to request data for new pages
defrecord Grex.API.Pagination.Pager, total: 0, page: nil
defrecord Grex.API.Pagination.Page,  start_item: 0, end_item: 0, items: []

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
