defmodule Tinn.Urls.CachedLoader do
  @moduledoc """
  Database data loader with cached results.
  """
  alias Tinn.Urls.{Encoder, Cache, Loader}

  def get_url(hash) do
    hash
    |> Cache.get_url()
    |> handle_cache_response(hash)
  end

  defp handle_cache_response({:ok, url}, _hash), do: {:ok, url}

  defp handle_cache_response({:error, _reason}, hash) do
    with {:ok, id} <- Encoder.decode(hash),
         {:ok, url} <- Loader.get_one(id) do
      Cache.put_url(hash, %{id: url.id, target: url.target})
      {:ok, url}
    end
  end
end
