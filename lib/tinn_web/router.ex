defmodule TinnWeb.Router do
  use TinnWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugSecex, except: ["content-security-policy"]
  end

  scope "/api", TinnWeb do
    pipe_through :api
  end
end
