defmodule Tinn.Repo.Migrations.CreateHits do
  use Ecto.Migration

  def change do
    create table(:hits) do
      add(:url_id, references(:urls, on_delete: :nothing))

      timestamps()
    end

    create(index(:hits, [:url_id]))
  end
end
