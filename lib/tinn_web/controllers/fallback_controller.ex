defmodule TinnWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use TinnWeb, :controller

  alias TinnWeb.Explode

  def call(conn, {:error, type}), do: Explode.reply(conn, type)
end
