defmodule MediumApi.Repo do
  use Ecto.Repo,
    otp_app: :medium_api,
    adapter: Ecto.Adapters.Postgres
end
