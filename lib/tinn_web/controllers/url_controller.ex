defmodule TinnWeb.UrlController do
  use TinnWeb, :controller

  alias Tinn.Urls

  action_fallback(TinnWeb.FallbackController)

  def create(conn, %{"url" => url}) do
    with {:ok, hash} <- Urls.shorten(url) do
      conn
      |> put_status(:created)
      |> render("create.json", hash: hash)
    end
  end

  def show(conn, %{"hash" => hash}) do
    with {:ok, url} <- Urls.get_url(hash) do
      conn
      |> render("show.json", url: url)
    end
  end

  def hits(conn, %{"hash" => hash}) do
    with {:ok, hits} <- Urls.get_hits(hash) do
      conn
      |> render("hits.json", hits)
    end
  end
end
