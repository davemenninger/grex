defmodule Grex do
  import Grex.API.Macros

  def start(key) do
    Grex.Client.start_link(key)
  end

  @doc """
  Lists shelves for a user

  Grex API method [shelves.list](http://www.goodreads.com/api#shelves.list)
  """
  defapimethod :shelves, [user_id]

end
