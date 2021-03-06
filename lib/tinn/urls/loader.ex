defmodule Tinn.Urls.Loader do
  @moduledoc """
  Database data loader.
  """
  alias Tinn.Repo
  alias Tinn.Urls.Queries

  def get_one(id) do
    id
    |> Queries.one_by_id()
    |> Repo.one()
    |> handle_get_one()
  end

  defp handle_get_one(nil), do: {:error, :shortened_url_not_found}
  defp handle_get_one(url), do: {:ok, url}

  def get_hits(url_id) do
    url_id
    |> Queries.hits_by_url()
    |> Repo.all()
  end

  def count_hits(url_id) do
    url_id
    |> Queries.count_hits_by_url()
    |> Repo.one()
    |> handle_count_hits()
  end

  defp handle_count_hits(nil), do: {:error, :shortened_url_not_found}
  defp handle_count_hits(count), do: {:ok, count}
end
