defmodule Poucet do
  @moduledoc """
  Simple module to get call an URL and if it redirects, chain call it's redirection targets all the way to the final target, or in case of redirect loop, the limit is reached.
  """

  @doc """

  ## Examples
  """

  @headers_browser [
    {"Accept",
     "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3"},
    {"Accept-Encoding", "gzip, deflate, br"},
    {"Accept-Languag", "en-US,en;q=0.9,fr;q=0.8,de;q=0.7"}
  ]

  defp extract_location_header(headers) do
    headers =
      headers
      |> Enum.map(fn {h1, h2} -> {String.downcase(h1), String.downcase(h2)} end)

    case List.keyfind(headers, "location", 0) do
      {_loc, redirect_location} ->
        redirect_location
    end
  end

  defp try_redirect(location = "http" <> _, count) when count < 10 do
    case HTTPoison.get(location, @headers_browser,
           follow_redirect: false,
           ssl: [{:versions, [:"tlsv1.2"]}]
         ) do
      {:ok,
       %HTTPoison.Response{
         headers: headers,
         status_code: status_code
       }}
      when status_code >= 300 and status_code <= 305 ->
        new_location = extract_location_header(headers)
        try_redirect(new_location, count + 1)

      {:ok,
       %HTTPoison.Response{
         status_code: _status_code
       }} ->
        location

      {:error, _error} ->
        location
    end
  end

  defp try_redirect(location, count) when count >= 10 do
    location
  end

  def final_location(url) do
    case HTTPoison.get(url, @headers_browser, ssl: [{:versions, [:"tlsv1.2"]}]) do
      {:ok,
       %HTTPoison.Response{
         status_code: status_code
       }}
      when status_code >= 400 ->
        {:error, status_code}

      {:ok,
       %HTTPoison.Response{
         headers: headers,
         status_code: status_code
       }}
      when status_code >= 300 ->
        redirect_location = headers |> extract_location_header
        final_location = try_redirect(redirect_location, 0)
        {:ok, final_location}

      {:ok,
       %HTTPoison.Response{
         status_code: 200
       }} ->
        {:ok, url}

      {:error, error} ->
        {:error, error}
    end
  end
end
