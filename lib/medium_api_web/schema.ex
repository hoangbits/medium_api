defmodule MediumApiWeb.Schema do
  use Absinthe.Schema

  alias MediumApi.{Repo, Accounts, Blog}
  alias MediumApiWeb.Resolvers
  alias MediumApiWeb.Schema.Middleware

  import_types(MediumApiWeb.Schema.Types)


  def middleware(middleware, _field, %{identifier: :mutation}) do
    # TODO add error middleware
    # middleware ++ [Middleware.ChangesetErrors]
    middleware ++ []
  end

  def middleware(middleware, _field, _object), do: middleware

  #
  # Add dataloader to middleware
  #
  def context(ctx) do
    source = Dataloader.Ecto.new(Repo)

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, source)
      |> Dataloader.add_source(Blog, source)

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.UserResolver.users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.UserResolver.register_user/3)
    end

    @desc "Login a user and return JWT token"
    field :login_user, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolvers.SessionResolver.login_user/3)
    end

    @desc "Create a post"
    field :create_post, type: :post_type do
      arg(:input, non_null(:post_input_type))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.PostResolver.create_post/3)
    end
    @desc "Create a comment"
    field :create_comment, type: :comment_type do
      arg(:input, non_null(:comment_input_type))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.CommentResolver.create_comment/3)
    end


  end

end
