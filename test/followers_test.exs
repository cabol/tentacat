defmodule Tentacat.FollowersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Followers

  doctest Tentacat.Users.Followers

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "following/1" do
    use_cassette "followers#following/1" do
      assert following(@client) == []
    end
  end

  test "following/2" do
    use_cassette "followers#following/2" do
      assert following("duksis", @client) == []
    end
  end

  test "followers/1" do
    use_cassette "followers#followers/1" do
      [%{"login" => username}] = followers(@client)
      assert username == "duksis"
    end
  end

  test "followers/2" do
    use_cassette "followers#followers/2" do
      assert followers("duksis", @client) == []
    end
  end

  test "following?/2" do
    use_cassette "followers#following?/2" do
      assert following?("duksis", @client) == true
    end
  end

  test "following?/3" do
    use_cassette "followers#following?/3" do
      assert following?("torvalds", "duksis", @client) == false
    end
  end

  test "follow/2" do
    use_cassette "followers#follow" do
      assert follow("duksis", @client) == true
    end
  end

  test "unfollow/2" do
    use_cassette "followers#unfollow" do
      assert unfollow("duksis", @client) == true
    end
  end

end
