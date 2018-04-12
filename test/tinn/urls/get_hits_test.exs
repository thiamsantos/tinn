defmodule Tinn.GetHitsTest do
  use Tinn.DataCase

  alias Faker.Internet
  alias Tinn.Urls.{Shorten, GetUrl, GetHits}

  def url_fixture(url) do
    {:ok, hash} = Shorten.call(url)
    hash
  end

  describe "GetHits.call/1" do
    test "should return the total of hits and a list of the accesses" do
      url = Internet.url()
      {:ok, hash} = Shorten.call(url)

      GetUrl.call(hash)
      GetUrl.call(hash)
      GetUrl.call(hash)

      {:ok, response} = GetHits.call(hash)

      assert response.count === 3
      assert length(response.hits) === 3
    end
  end
end
