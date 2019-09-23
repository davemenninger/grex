defmodule Grex.API.Shelf do
  import Grex.API.Util
  require Record

  Record.defrecord :shelf, id: 0, book_count: 0, name: "", description: "",
                          exclusive_flag: false, featured: false,
    per_page: 0, recommend_for: true, sort: true, sticky: false , order: ""

  def from_node(node) do
    shelf(
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

end
