defmodule Goodreads.Client do

  def start(key) do
    HTTPotion.start
    spawn(Goodreads.Client, :run, [key])
  end

  defp parse(body),  do: body |> :erlsom.simple_form

  defp body(record), do: record.body

  defp request(url), do: url |> HTTPotion.get |> body |> parse

  def run(key) do
    receive do
      {pid, :shelves, user_id} ->
        data = request("http://www.goodreads.com/shelf/list.xml?user_id=#{user_id}&key=#{key}")
        pid <- {:ok, data}
    end
    run(key)
  end

end