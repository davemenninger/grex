defmodule Grex.API.Macros do

  defmacro defapimethod(name, args) do
    quote do
      def unquote(name)(unquote_splicing(args)) do
        case Grex.Client.unquote(name)(unquote_splicing(args)) do
          {:ok, data, []} -> {:ok, data}
          other -> other
        end       
      end
    end
  end
  
end