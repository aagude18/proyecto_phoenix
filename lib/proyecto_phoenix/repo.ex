defmodule ProyectoPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :proyecto_phoenix,
    adapter: Ecto.Adapters.Postgres
end
