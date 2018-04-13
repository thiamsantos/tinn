defmodule Tinn.Urls.Cache do
  @moduledoc """
  Wrapper around cachex to provide in-memory cache.
  """
  @cache_name :tinn_cache

  @spec put_url(String.t(), map()) :: {:ok, map()} | {:error, atom()}
  def put_url(hash, url) when is_binary(hash) do
    @cache_name
    |> Cachex.put(url_key(hash), url, ttl: :timer.minutes(60))
    |> handle_put_url()
  end

  def handle_put_url({:ok, true}, url), do: {:ok, url}
  def handle_put_url(_), do: {:error, :cache_error}

  @spec get_url(String.t()) :: {:ok, map()} | {:error, atom()}
  def get_url(hash) when is_binary(hash) do
    @cache_name
    |> Cachex.get(url_key(hash))
    |> handle_get_url()
  end

  defp url_key(hash), do: "url:#{hash}"

  defp handle_get_url({:ok, nil}), do: {:error, :hash_not_found}
  defp handle_get_url({:ok, value}), do: {:ok, value}
  defp handle_get_url(_), do: {:error, :cache_error}
end
