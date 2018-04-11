defmodule Tinn.Urls do
  @moduledoc """
  The Urls context.
  """
  alias Ecto.Changeset
  alias Tinn.Urls.{Url, Encoder, Loader, Mutator}

  @doc """
  Gets a single url with a given hash.
  """
  def get_url(hash) when is_binary(hash) do
    with {:ok, id} <- Encoder.decode(hash),
         {:ok, url} <- Loader.get_one(id),
         {:ok, _hit} <- Mutator.hit(url.id) do
      {:ok, url.target}
    end
  end

  def get_url(_), do: {:error, :invalid_shortened_url}

  @doc """
  Shortens a url.
  """
  def shorten(url) do
    with {:ok, %Url{} = url} <- Mutator.insert(url) do
      {:ok, Encoder.encode(url.id)}
    else
      {:error, %Changeset{} = _changeset} -> {:error, :invalid_url}
    end
  end

  @doc """
  Gets the total of hits and a list of the access.
  """
  def get_hits(hash) when is_binary(hash) do
    with {:ok, id} <- Encoder.decode(hash),
         {:ok, count} <- Loader.count_hits(id),
         hits <- Loader.get_hits(id) do
      {:ok, %{hits: hits, count: count}}
    end
  end

  def get_hits(_), do: {:error, :invalid_shortened_url}
end
