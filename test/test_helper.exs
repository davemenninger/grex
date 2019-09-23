ExUnit.start

defmodule TestMacros do

  defmacro test_with_http_mock(test_name, method, fixture_name, test_block) do
    quote do
      test_with_mock unquote(test_name),
        HTTPotion, [
          {:start, fn() -> end},
          {unquote(method), fn(_url) -> %HTTPotion.Response{ body: fixture(unquote(fixture_name)) } end}
        ] do
        unquote(test_block)
      end
    end
  end

end

defmodule TestFixtures do

  defp fixture_path(name) do
    filename = "#{name}.xml"
    Path.join(["test", "fixtures", filename])
  end

  def fixture(name) do
    {:ok, xml} = name |> fixture_path |> File.read
    xml
  end
  
end
