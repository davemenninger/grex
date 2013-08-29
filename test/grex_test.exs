Code.require_file "test_helper.exs", __DIR__

defmodule GrexTest do
  use ExUnit.Case
  import Mock
  import TestMacros
  import TestFixtures

  # Fake key
  @key "1cZmg3UyTIddH3AoH2R7qQ"
  @user_id 5281207

  setup do
    Grex.start(@key)
    :ok
  end 

  test_with_http_mock "list user shelves", :get, "shelves_list" do
    data = Grex.shelves(@user_id)
    assert data.total == 5
    [head | tail] = data.page.items
    assert head.name == "read"
  end

end