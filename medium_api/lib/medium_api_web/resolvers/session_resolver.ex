defmodule MediumApiWeb.Resolvers.SessionResolver do
  alias MediumApi.{Accounts,Guardian}


  def login_user(_,%{input: input},_) do
    # authenticate
    # issue token and user info
    with {:ok, user} <- Accounts.Session.authenticate(input),
        {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
          {:ok, %{token: jwt_token, user: user}}
    end
  end

end
