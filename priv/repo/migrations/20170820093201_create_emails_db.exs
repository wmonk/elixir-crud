defmodule Communications.Repo.Migrations.CreateEmailsDb do
  use Ecto.Migration

  def change do
    create table(:emails, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :to, :string
      add :from, :string
      add :subject, :string
      add :sent, :boolean
    end
  end
end
