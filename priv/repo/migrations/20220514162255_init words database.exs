defmodule :"Elixir.Starnik.Repo.Migrations.Init words database" do
  use Ecto.Migration

  def change do
    create table(:words, primary_key: false) do
      add :id, :bigserial, primary_key: true
      add :word, :string, null: false

      timestamps(type: :timestamptz, updated_at: false)
    end

    create unique_index(:words, [:word])

    execute """
      CREATE INDEX words_inserted_at_index on words using brin(word);
    """

    execute """
      ALTER TABLE words ALTER COLUMN inserted_at SET DEFAULT NOW();
    """
  end
end
