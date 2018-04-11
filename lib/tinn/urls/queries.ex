defmodule Tinn.Urls.Queries do
  import Ecto.Query, warn: false

  alias Tinn.Urls.Url

  def one_by_id(id) do
    from u in Url, where: u.id == ^id
  end
end
