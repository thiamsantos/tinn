defmodule Tinn.Urls.Shorten do
  @moduledoc """
  Shortens a url.
  """
  use Tinn.Service

  alias Ecto.Changeset
  alias Tinn.Urls.{Encoder, Mutator, Url}

  def run(url) do
    with {:ok, %Url{} = url} <- Mutator.insert(url) do
      {:ok, Encoder.encode(url.id)}
    else
      {:error, %Changeset{} = _changeset} -> {:error, :invalid_url}
    end
  end
end
