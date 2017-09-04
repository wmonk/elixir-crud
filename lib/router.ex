defmodule Communications.Router do
  use Plug.Router
  require Plug.Conn

  plug :match
  plug Plug.Parsers, parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  plug :dispatch

  get "/emails" do
    {:ok, emails} = Communications.Repo.all(Communications.Email) |> Poison.encode
    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(200, emails)
  end

  post "/emails" do
    new_email = Communications.Email.changeset(%Communications.Email{}, conn.body_params)
    if new_email.valid? == false do
      errors = Ecto.Changeset.traverse_errors(new_email, fn {msg, opts} ->
        msg
      end)
      conn
      |> put_resp_header("Content-Type", "application/json")
      |> send_resp(400, Poison.encode!(errors))
    end

    msg = case Communications.Repo.insert(new_email) do
      {:ok, email} -> Poison.encode!(email)
      {:error, _} -> "boop"
    end

    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(201, msg)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
