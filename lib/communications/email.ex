defmodule Communications.Email do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:to, :from, :subject, :sent, :id]}
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "emails" do
    field :to, :string
    field :from, :string
    field :subject, :string
    field :sent, :boolean
  end

  def changeset(email, params \\ %{}) do
    email
    |> cast(params, [:to, :from, :subject])
    |> validate_required([:to, :from, :subject])
    |> validate_format(:to, ~r/@/)
    |> validate_format(:from, ~r/@/)
  end
end

