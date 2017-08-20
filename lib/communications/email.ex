defmodule Communications.Email do
  use Ecto.Schema

  schema "emails" do
    field :to, :string
    field :from, :string
    field :subject, :string
    field :sent, :boolean
  end
end
