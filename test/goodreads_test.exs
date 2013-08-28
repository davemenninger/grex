defmodule GoodreadsTest do
  use ExUnit.Case

  @key "1cZmg3UyTIddH3AoH2R7qQ"

  test "the truth" do

 	conn = Goodreads.Client.start(@key)
    conn <- {self, :shelves, 5281207}
    receive do
      {:ok, data} ->
      	IO.inspect(data)
      	assert data
    end
  end
end
