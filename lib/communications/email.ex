defmodule Communications.Email do
  use Ecto.Schema

  @derive {Poison.Encoder, only: [:to, :from, :subject, :sent, :id]}
  schema "emails" do
    field :to, :string
    field :from, :string
    field :subject, :string
    field :sent, :boolean
  end
end
