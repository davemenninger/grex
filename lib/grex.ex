defmodule Grex do
  import Grex.API.Macros

  def start(key) do
    Grex.Client.start(key)
  end

  @doc """
  Lists shelves for a user

  Grex API method [shelves.list](http://www.Grex.com/api#shelves.list)
  """
  defapimethod :shelves, [user_id]

end