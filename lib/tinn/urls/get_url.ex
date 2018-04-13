defmodule Tinn.Urls.GetUrl do
  @moduledoc """
  Gets a single url with a given hash.
  """
  use Tinn.Service
  alias Tinn.Urls.{CachedLoader, Mutator}

  def run(hash) when is_binary(hash) do
    with {:ok, url} <- CachedLoader.get_url(hash),
         {:ok, _hit} <- Mutator.hit(url.id) do
      {:ok, url.target}
    end
  end

  def run(_), do: {:error, :invalid_shortened_url}
end
