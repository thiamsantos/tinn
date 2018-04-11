defmodule TinnWeb.Explode do
  @moduledoc """
  Utility for responding with standard HTTP/JSON error payloads
  """
  alias Plug.Conn

  @spec reply(Conn.t(), atom) :: Conn.t()
  def reply(conn, type) do
    status =
      type
      |> get_status_code()

    payload =
      type
      |> get_message()
      |> build_payload(type)

    conn
    |> do_reply(status, payload)
  end

  @spec do_reply(Conn.t(), integer, map) :: Conn.t()
  defp do_reply(conn, status_code, payload) do
    conn
    |> Conn.put_resp_content_type("application/json")
    |> Conn.send_resp(status_code, Jason.encode!(payload))
    |> Conn.halt()
  end

  @spec build_payload(String.t(), atom) :: map
  defp build_payload(message, type) do
    %{
      "code" => get_error_code(type),
      "message" => message
    }
  end

  defp get_message(:shortened_url_not_found), do: "Shortened url not found"
  defp get_message(:invalid_url), do: "Invalid url"

  defp get_status_code(:shortened_url_not_found), do: 404
  defp get_status_code(:invalid_url), do: 422

  defp get_error_code(:shortened_url_not_found), do: 101
  defp get_error_code(:invalid_url), do: 102
end
