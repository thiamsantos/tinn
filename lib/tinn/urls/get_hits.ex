defmodule Tinn.Urls.GetHits do
  @moduledoc """
  Gets the total of hits and a list of the access.
  """
  use Tinn.Service

  alias Tinn.Urls.{Encoder, Loader, Mutator}

  def run(hash) when is_binary(hash) do
    with {:ok, id} <- Encoder.decode(hash),
         {:ok, count} <- Loader.count_hits(id),
         hits <- Loader.get_hits(id) do
      {:ok, %{hits: hits, count: count}}
    end
  end

  def run(_), do: {:error, :invalid_shortened_url}
end
