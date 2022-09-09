defmodule FTX.Futures do
  @base_path "/futures/"

  def get_futures do
    @base_path
    |> String.trim_trailing("/")
    |> FTX.build_url()
    |> HTTPoison.get()
    |> FTX.handle_response()
  end

  def get_future(future) when is_binary(future) do
    (@base_path <> future)
    |> FTX.build_url()
    |> HTTPoison.get()
    |> FTX.handle_response()
  end

  def get_funding_rate(future) when is_binary(future) do
    "/funding_rates"
    |> FTX.build_url()
    |> HTTPoison.get([], params: [future: future])
    |> FTX.handle_response()
  end

  def get_funding_rates do
    "/funding_rates"
    |> FTX.build_url()
    |> HTTPoison.get()
    |> FTX.handle_response()
  end
end
