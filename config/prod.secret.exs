# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :wishlist, Wishlist.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :wishlist, WishlistWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

http_basic_auth_username =
  System.get_env("HTTP_BASIC_AUTH_USERNAME") ||
    raise """
    environment variable HTTP_BASIC_AUTH_USERNAME is missing.
    """

http_basic_auth_password =
  System.get_env("HTTP_BASIC_AUTH_PASSWORD") ||
    raise """
    environment variable HTTP_BASIC_AUTH_PASSWORD is missing.
    """

# Set basic auth from environment variables
config :wishlist, :basic_auth, username: http_basic_auth_username, password: http_basic_auth_password

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :wishlist, WishlistWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
