defmodule Communications.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  get "/emails" do
    {:ok, emails} = Communications.Repo.all(Communications.Email) |> Poison.encode
    send_resp(conn, 200, emails)
  end

  post "/emails" do
    new_email = %Communications.Email{from: "will", to: "me"}
    Communications.Repo.insert(new_email)
    send_resp(conn, 201, "Done!")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
