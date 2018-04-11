defmodule Tinn.Urls.Mutator do
  @moduledoc """
  Database mutations.
  """
  alias Tinn.Repo
  alias Tinn.Urls.Url

  def insert(url) do
    %Url{}
    |> Url.changeset(%{target: url})
    |> Repo.insert()
  end
end
