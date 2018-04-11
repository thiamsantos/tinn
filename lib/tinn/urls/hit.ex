defmodule Tinn.Urls.Hit do
  @moduledoc """
  Hit schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @fields [:url_id]

  schema "hits" do
    field :url_id, :id

    timestamps()
  end

  @doc false
  def changeset(hits, attrs) do
    hits
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> foreign_key_constraint(:post_id)
  end
end
