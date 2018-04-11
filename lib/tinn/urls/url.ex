defmodule Tinn.Urls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :target, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:target])
    |> validate_required([:target])
  end
end
