Code.require_file "test_helper.exs", __DIR__

defmodule GrexTest do
  use ExUnit.Case
  import Mock
  import TestMacros
  import TestFixtures

  import Grex.API.Pagination
  import XmlNode

  # Fake key
  @key "1cZmg3UyTIddH3AoH2R7qQ"
  @user_id 5281207

  setup do
    Grex.start(@key)
    :ok
  end

  test_with_http_mock "list user shelves", :get, "shelves_list" do
    data = Grex.shelves(@user_id)
    assert pager(data, :total) == 5

    [head | _] = page(
      pager(data, :page),
      :items)
    [name_element] = :xmerl_xpath.string('/user_shelf/name', head) 
    [content] = xmlElement(name_element, :content)
    assert xmlText(content, :value) == 'read'

    [id_element] = :xmerl_xpath.string('/user_shelf/id', head) 
    [content] = xmlElement(id_element, :content)
    assert xmlText(content, :value) == '17090812'
  end

end
