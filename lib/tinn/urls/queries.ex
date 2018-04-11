defmodule Tinn.Urls.Queries do
  @moduledoc """
  Database queries.
  """
  import Ecto.Query, warn: false

  alias Tinn.Urls.{Url, Hit}

  def one_by_id(id) do
    from u in Url, where: u.id == ^id
  end

  def hits_by_url(url_id) do
    from h in Hit, where: h.url_id == ^url_id, select: h.inserted_at
  end

  def count_hits_by_url(url_id) do
    from h in Hit,
      where: h.url_id == ^url_id,
      select: count(h.id)
  end
end
