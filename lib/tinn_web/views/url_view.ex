defmodule TinnWeb.UrlView do
  use TinnWeb, :view

  def render("create.json", %{hash: hash}) do
    %{hash: hash}
  end

  def render("show.json", %{url: url}) do
    %{url: url}
  end
end
