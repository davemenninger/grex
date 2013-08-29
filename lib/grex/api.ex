defmodule Grex.API do

  def shelves(xml) do
    node = xml |> XmlNode.first("//shelves")
    Grex.API.Pagination.build(node, &Grex.API.Shelf.from_node/1)
  end

end
