defmodule Communications.Repo.Migrations.CreateEmailsDb do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :to, :string
      add :from, :string
      add :subject, :string
      add :sent, :boolean
    end
  end
end
