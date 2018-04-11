defmodule Tinn.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add(:target, :string)

      timestamps()
    end
  end
end
