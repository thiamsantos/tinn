defmodule Tinn.ShortenTest do
  use Tinn.DataCase

  alias Faker.Internet
  alias Tinn.Repo
  alias Tinn.Urls.{Url, Encoder, Shorten}

  def url_fixture(url) do
    {:ok, hash} = Urls.Shorten.call(url)
    hash
  end

  describe "call/1" do
    test "returns a hash of the record id in the database" do
      url = Internet.url()
      {:ok, hash} = Shorten.call(url)

      {:ok, id} = Encoder.decode(hash)
      url_record = Repo.get!(Url, id)

      assert url === url_record.target
    end

    test "returns invalid url" do
      actual = Shorten.call(nil)
      expected = {:error, :invalid_url}

      assert actual === expected
    end
  end
end
