defmodule Starnik.Repo.Migrations.AddAnagramsTable do
  use Ecto.Migration

  def up do
    create table(:anagrams, primary_key: false) do
      add :id, :bigserial, primary_key: true
      add :letters, :string, null: false
      add :words, {:array, :string}, null: false

      timestamps(type: :timestamptz, updated_at: false)
    end

    create unique_index(:anagrams, [:letters])

    execute """
      CREATE INDEX anagrams_inserted_at_index ON anagrams USING brin(inserted_at);
    """

    execute """
      ALTER TABLE anagrams ALTER COLUMN inserted_at SET DEFAULT NOW();
    """
  end

  def down do
    execute """
      DROP TABLE anagrams;
    """
  end
end
