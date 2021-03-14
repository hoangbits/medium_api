defmodule MediumApi.Guardian do
  use Guardian, otp_app: :medium_api
  alias MediumApi.Accounts

  def subject_for_token(%Accounts.User{} = user, _claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.
    {:ok, to_string(user.id)}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    # id = claims["sub"]
    # resource = MediumApi.get_resource_by_id(id)
    case Accounts.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end

  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
