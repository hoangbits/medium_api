defmodule MediumApiWeb.Schema.Types.CommentType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MediumApi.{Accounts, Blog}

  object :comment_type do
    field(:id, :id)
    field(:content, :string)
    field(:user, :user_type, resolve: dataloader(Accounts))
    field(:post, :post_type, resolve: dataloader(Blog))
  end

  input_object :comment_input_type do
    field(:content, non_null(:string))
    field(:post_id, non_null(:id))
  end

end
