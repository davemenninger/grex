defmodule Grex.Client do
  use ExActor.GenServer, export: :singleton
  #import Grex.Client.Util

  defstart start_link(key), do: init(key)

  def init(key) do
    HTTPotion.start
    initial_state(key)
  end

  defcall shelves(user_id), state: key do
   pager = Grex.Client.Util.get("shelf/list", [key: key, user_id: user_id])
   |> Grex.API.shelves
   reply(pager)
  end

end
