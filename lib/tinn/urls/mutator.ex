defmodule Tinn.Urls.Mutator do
  @moduledoc """
  Database mutations.
  """
  alias Tinn.Repo
  alias Tinn.Urls.{Url, Hit}

  def insert(url) do
    %Url{}
    |> Url.changeset(%{target: url})
    |> Repo.insert()
  end

  def hit(id) do
    %Hit{}
    |> Hit.changeset(%{url_id: id})
    |> Repo.insert()
  end
end
