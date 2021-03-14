defmodule MediumApi.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias MediumApi.Accounts.User
  alias MediumApi.Blog.Post

  schema "comments" do
    field :content, :string
    # field :user_id, :id
    # field :post_id, :id
    belongs_to(:user, User)
    belongs_to(:post, Post)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :user_id, :post_id])
    |> validate_required([:content, :user_id, :post_id])
  end
end
