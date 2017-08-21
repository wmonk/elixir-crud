defmodule Communications.Email do
  use Ecto.Schema

  @derive {Poison.Encoder, only: [:to]}
  schema "emails" do
    field :to, :string
    field :from, :string
    field :subject, :string
    field :sent, :boolean
  end
end
