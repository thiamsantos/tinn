defmodule Tinn.UrlsTest do
  use Tinn.DataCase

  alias Faker.Internet
  alias Tinn.{Urls, Repo}
  alias Tinn.Urls.{Url, Encoder}

  def url_fixture(url) do
    {:ok, hash} = Urls.Shorten.call(url)
    hash
  end

  describe "GetUrl.call/1 " do
    test "returns the url with given hash" do
      url = Internet.url()
      hash = url_fixture(url)

      actual = Urls.GetUrl.call(hash)
      expected = {:ok, url}

      assert actual == expected
    end

    test "returns hash not found" do
      hash = Encoder.encode(1)
      actual = Urls.GetUrl.call(hash)
      expected = {:error, :shortened_url_not_found}

      assert actual == expected
    end

    test "returns invalid shortened url" do
      actual = Urls.GetUrl.call(nil)
      expected = {:error, :invalid_shortened_url}

      assert actual == expected
    end
  end

  describe "Shorten.call/1" do
    test "returns a hash of the record id in the database" do
      url = Internet.url()
      {:ok, hash} = Urls.Shorten.call(url)

      {:ok, id} = Encoder.decode(hash)
      url_record = Repo.get!(Url, id)

      assert url === url_record.target
    end

    test "returns invalid url" do
      actual = Urls.Shorten.call(nil)
      expected = {:error, :invalid_url}

      assert actual === expected
    end
  end

  describe "GetHits.call/1" do
    test "should return the total of hits and a list of the accesses" do
      url = Internet.url()
      {:ok, hash} = Urls.Shorten.call(url)

      Urls.GetUrl.call(hash)
      Urls.GetUrl.call(hash)
      Urls.GetUrl.call(hash)

      {:ok, response} = Urls.GetHits.call(hash)

      assert response.count === 3
      assert length(response.hits) === 3
    end
  end
end
