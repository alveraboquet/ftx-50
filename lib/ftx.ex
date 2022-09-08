defmodule FTX do
  @base_url "https://ftx.com/api"

  def build_url(url) do
    @base_url <> url
  end

  def handle_response({status, %HTTPoison.Response{body: body, headers: headers} = response}) do
    if json?(headers) do
      case Jason.decode(body) do
        {:ok, decoded_body} ->
          {status, %HTTPoison.Response{response | body: decoded_body}}

        {:error, reason} ->
          {:error, {:decode_error, reason, {status, response}}}
      end
    else
      {status, response}
    end
  end

  def handle_response({:error, %HTTPoison.Error{}} = error), do: error

  defp json?(headers) do
    Enum.find_value(headers, false, fn {key, value} ->
      if String.downcase(key) == "content-type" do
        value == "application/json"
      end
    end)
  end
end
