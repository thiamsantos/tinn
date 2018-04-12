defmodule Tinn.GetUrlTest do
  use Tinn.DataCase

  alias Faker.Internet
  alias Tinn.Urls.{Encoder, GetUrl, Shorten}

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
