defmodule TinnWeb.Router do
  use TinnWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugSecex, except: ["content-security-policy"]
  end

  scope "/api", TinnWeb do
    pipe_through :api

    post "/urls", UrlController, :create
    get "/urls/:hash", UrlController, :show
    get "/urls/:hash/hits", UrlController, :hits
  end
end
