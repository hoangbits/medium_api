defmodule MediumApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias MediumApi.Accounts.User

  schema "posts" do
    field :title, :string
    field :content, :string
    field :published, :boolean, default: false
    # field :user_id, :id
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :published, :user_id])
    |> validate_required([:title, :content, :published, :user_id])
  end
end
