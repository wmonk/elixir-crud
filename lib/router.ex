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
    case conn.body_params do
      %{"from" => from, "to": to} ->
        new_email = %Communications.Email{from: from, to: to}
        msg = case Communications.Repo.insert(new_email) do
          {:ok, email} -> case Poison.encode(email) do
            {:ok, msg} -> msg
            {:invalid, what} -> what
          end
          {:error, email} -> email
          _ -> "No ideaa"
        end
        conn
        |> put_resp_header("Content-Type", "application/json")
        |> send_resp(201, msg)
      _ ->
        IO.inspect conn.body_params
        send_resp(conn, 400, "Bad body")
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
