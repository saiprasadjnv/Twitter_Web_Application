defmodule TwitterSimWeb.TweetController do
  use TwitterSimWeb, :controller
import Ecto.Query, warn: false
  alias TwitterSim.Tweet
  alias TwitterSim.Repo

  def index(conn, _) do #%{"user" => user}
    my_tweets = Enum.reverse(Repo.all(Tweet))
    #my_tweets = Tweet |> where(from: ^user) |> Repo.all()
    my_mentions = []#Tweet |> where(mentions: ^user) |> Repo.all()
    #new_tweets =
    render(conn, "index.html", my_tweets: my_tweets, my_mentions: my_mentions)#, user: user)
  end

  def new(conn, _) do #%{"user" => user
    changesetTweet = Tweet.changeset(%Tweet{}, %{})
    render(conn, "new.html", changesetTweet: changesetTweet)#, user: user)
  end

  def create(conn, %{"tweet" => tweet_info}) do
    IO.puts "tweet_info"
    IO.inspect tweet_info
    #IO.inspect %Tweet{} |> Tweet.changeset(tweet_info)
    {status, _} = %Tweet{} |> Tweet.changeset(tweet_info) |> Repo.insert()
  # {status, _} = %Tweet{} |> Repo.insert(Tweet%{tweet: tweet_info})
  # {status, _} = Repo.insert(%Tweet{tweet: tweet_info})
  if status == :ok, do: redirect(conn, to: Routes.tweet_path(conn, :index)), else: conn |> put_flash(:error, "Could not create tweet") |> redirect(to: Routes.tweet_path(conn, :index))
  end

  def retweet(conn, %{"tweet" => re_tweet}) do
    Repo.insert(%Tweet{tweet: re_tweet})
    #{status, _} = %Tweet{} |> Tweet.changeset(re_tweet) |> Repo.insert()
    #if status == :ok, do: redirect(conn, to: Routes.tweet_path(conn, :index)), else: conn |> put_flash(:error, "Could not re-tweet") |> redirect(to: Routes.tweet_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    [ref_tweet] = Tweet |> where(id: ^id) |> Repo.all()
    #IO.inspect ref_tweet
    render(conn, "show.html", ref_tweet: ref_tweet)
  end

  def delete(conn, %{"id" => id}) do
  #  del_tweet = Repo.get!(Room, id)
    {status, _} = Repo.delete(Repo.get!(Tweet, id))
    #{status, _} = %Tweet{} |> Tweet.changeset(%{"id" => id}) |> Repo.delete()
    ##{status, _} = Repo.delete(tweet)
    if status == :ok, do: redirect(conn, to: Routes.tweet_path(conn, :index)), else: conn |> put_flash(:error, "Could not delete tweet") |> redirect(to: Routes.tweet_path(conn, :index))
  end

  def checkForMentions(tweet) do

  end

  def checkForHashtags(tweet) do

  end
end
