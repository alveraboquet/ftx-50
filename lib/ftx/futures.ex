defmodule FTX.Futures do
  @base_path "/futures/"

  def get_future(future) when is_binary(future) do
    (@base_path <> future)
    |> FTX.build_url()
    |> HTTPoison.get()
    |> FTX.handle_response()
  end
end
