defmodule Grex.API do
  import Grex.API.Util

  defp shelf_from_node(node) do
    Grex.API.Shelf.new(
      id:             node |> value("id"),
      book_count:     node |> value("book_count"),
      exclusive_flag: node |> value("exclusive_flag"),
      featured:       node |> value("featured"),
      name:           node |> value("name"),
      order:          node |> value("order"),
      per_page:       node |> value("per_page"),
      sticky:         node |> value("sticky")
    )
  end

  def shelves(xml) do
    node = xml |> XmlNode.first("//shelves")
    Grex.API.Pagination.build(node, &shelf_from_node/1)
  end

end
