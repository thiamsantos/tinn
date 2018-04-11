defmodule Tinn.Urls.Loader do
  alias Tinn.Repo
  alias Tinn.Urls.Queries

  def get_one(id) do
    id
    |> Queries.one_by_id()
    |> Repo.one()
    |> handle_get_one()
  end

  defp handle_get_one(url) when is_nil(url) do
    {:error, :shortened_url_not_found}
  end

  defp handle_get_one(url) do
    {:ok, url}
  end
end
