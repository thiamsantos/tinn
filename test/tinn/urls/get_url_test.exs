defmodule Tinn.GetUrlTest do
  use Tinn.DataCase

  alias Faker.Internet
  alias Tinn.Urls.{Encoder, GetUrl, Shorten, Cache}

  def url_fixture(url) do
    {:ok, hash} = Shorten.call(url)
    hash
  end

  describe "call/1 " do
    test "returns the url with given hash" do
      url = Internet.url()
      hash = url_fixture(url)

      actual = GetUrl.call(hash)
      expected = {:ok, url}

      assert actual == expected
    end

    test "get_url should cache the results" do
      url = Internet.url()
      hash = url_fixture(url)
      {:ok, id} = Encoder.decode(hash)

      actual = GetUrl.call(hash)
      expected = {:ok, url}

      assert Cache.get_url(hash) === {:ok, %{id: id, target: url}}

      assert actual == expected
    end

    test "returns hash not found" do
      hash = Encoder.encode(1)
      actual = GetUrl.call(hash)
      expected = {:error, :shortened_url_not_found}

      assert actual == expected
    end

    test "returns invalid shortened url" do
      actual = GetUrl.call(nil)
      expected = {:error, :invalid_shortened_url}

      assert actual == expected
    end
  end
end
