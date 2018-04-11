defmodule Tinn.UrlsTest do
  use Tinn.DataCase

  alias Faker.Internet
  alias Tinn.{Urls, Repo}
  alias Tinn.Urls.{Url, Encoder}

  def url_fixture(url) do
    {:ok, hash} = Urls.shorten(url)
    hash
  end

  describe "get_url/1 " do
    test "returns the url with given hash" do
      url = Internet.url()
      hash = url_fixture(url)

      actual = Urls.get_url(hash)
      expected = {:ok, url}

      assert actual == expected
    end

    test "returns hash not found" do
      hash = Encoder.encode(1)
      actual = Urls.get_url(hash)
      expected = {:error, :shortened_url_not_found}

      assert actual == expected
    end

    test "returns invalid shortened url" do
      actual = Urls.get_url(nil)
      expected = {:error, :invalid_shortened_url}

      assert actual == expected
    end
  end

  describe "shorten/1" do
    test "returns a hash of the record id in the database" do
      url = Internet.url()
      {:ok, hash} = Urls.shorten(url)

      {:ok, id} = Encoder.decode(hash)
      url_record = Repo.get!(Url, id)

      assert url === url_record.target
    end

    test "returns invalid url" do
      actual = Urls.shorten(nil)
      expected = {:error, :invalid_url}

      assert actual === expected
    end
  end
end
