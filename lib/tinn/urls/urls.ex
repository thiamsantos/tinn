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
         {:ok, url} <- Loader.get_one(id) do
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
end
