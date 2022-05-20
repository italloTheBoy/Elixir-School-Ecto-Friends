defmodule Friends.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string,  size: 80, null: false
      add :age,  :integer, default: 1
    end
  end
end
