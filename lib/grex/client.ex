defmodule Grex.Client do
  use ExActor, export: :singleton
  import Grex.Client.Util

  def init(key) do
    HTTPotion.start
    initial_state(key)
  end

  defcall shelves(user_id), state: key do
    get("shelf/list", [key: key, user_id: user_id]) |> Grex.API.shelves
  end

end