defmodule TinnWeb.UrlControllerTest do
  use TinnWeb.ConnCase

  alias Faker.Internet
  alias Tinn.{Urls, Repo}
  alias Tinn.Urls.{Url, Encoder}

  def url_fixture(url) do
    {:ok, hash} = Urls.Shorten.call(url)
    hash
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create shorten url" do
    test "returns hash when url is valid", %{conn: conn} do
      url = Internet.url()
      conn = post conn, url_path(conn, :create), url: url
      assert %{"hash" => hash} = json_response(conn, 201)

      {:ok, id} = Encoder.decode(hash)
      url_record = Repo.get!(Url, id)

      assert url === url_record.target
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, url_path(conn, :create), url: nil

      actual = json_response(conn, 422)
      expected = %{"code" => 102, "message" => "Invalid url"}

      assert actual === expected
    end
  end

  describe "show url" do
    test "renders url when hash is valid", %{conn: conn} do
      url = Internet.url()
      hash = url_fixture(url)

      conn = get conn, url_path(conn, :show, hash)
      actual = json_response(conn, 200)
      expected = %{"url" => url}

      assert actual === expected
    end

    test "renders error response", %{conn: conn} do
      conn = get conn, url_path(conn, :show, 1)
      actual = json_response(conn, 404)
      expected = %{"code" => 101, "message" => "Shortened url not found"}

      assert actual === expected
    end
  end

  describe "hits" do
    test "should return the total of hits", %{conn: conn} do
      url = Internet.url()
      {:ok, hash} = Urls.Shorten.call(url)

      Urls.GetUrl.call(hash)
      Urls.GetUrl.call(hash)
      Urls.GetUrl.call(hash)

      conn = get conn, url_path(conn, :hits, hash)
      actual = json_response(conn, 200)

      assert actual["count"] === 3
      assert length(actual["hits"]) === 3
    end
  end
end
