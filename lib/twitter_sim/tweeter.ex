defmodule TwitterSim.Tweeter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweeters" do
    field :crypto_pass, :string, null: false
    field :handle, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(tweeter, attrs) do
    tweeter
    |> cast(attrs, [:handle, :crypto_pass])
    |> validate_required([:handle, :crypto_pass])
    |> unique_constraint(:handle)
  end
end
