defmodule Friends.People do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias __MODULE__, as: This
  alias Friends.Repo, as: DB

  schema "people" do
    field(:name, :string)
    field(:age,  :integer, default: 1)
  end

  defp validate_captalize(changeset, field) do
    name = get_field(changeset, field)

    name_captalized = 
      name
      |> String.split()
      |> Enum.map(fn string -> String.capitalize(string) end)
      |> Enum.join(" ")

    if name != name_captalized do
      add_error(changeset, field, "a primeira letra de cada nome deve ser maiuscula")
    else
      changeset
    end 
  end

  defp validate_name(changeset) do
    changeset
    |> validate_required(:name, message: "insira um nome")
    |> validate_length(:name, min: 3,  message: "nome muito curto")
    |> validate_length(:name, max: 80, message: "nome muito longo")
    |> validate_captalize(:name)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :age])
    |> validate_name()
  end 

  def insert_people(struct, params) do
    struct
    |> changeset(params)
    |> DB.insert()
  end

  def get_by_id(id) do
    This |> DB.get(id)
  end

  def get_all do  
    This |> DB.all()
  end

  def get_by_name(name) do
    This |> DB.get_by(name: name)
  end

  def update_people(id, changes) do
    id
    |> get_by_id()
    |> changeset(changes)
    |> DB.update()
  end

  def delete_people(id) do
    id
    |> get_by_id()
    |> DB.delete()
  end

end
