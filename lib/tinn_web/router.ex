defmodule TinnWeb.Router do
  use TinnWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugSecex, except: ["content-security-policy"]
  end

  scope "/api", TinnWeb do
    pipe_through :api

    get "/urls/:hash", UrlController, :show
    post "/urls", UrlController, :create
  end
end
