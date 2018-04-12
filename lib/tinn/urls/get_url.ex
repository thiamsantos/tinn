defmodule Tinn.Urls.GetUrl do
  @moduledoc """
  Gets a single url with a given hash.
  """
  use Tinn.Service
  alias Tinn.Urls.{Encoder, Loader, Mutator}

  def run(hash) when is_binary(hash) do
    with {:ok, id} <- Encoder.decode(hash),
         {:ok, url} <- Loader.get_one(id),
         {:ok, _hit} <- Mutator.hit(url.id) do
      {:ok, url.target}
    end
  end

  def run(_), do: {:error, :invalid_shortened_url}
end
