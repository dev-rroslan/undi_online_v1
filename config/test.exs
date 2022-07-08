import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :undi_online, UndiOnline.Repo,
  username: "postgres",
  password: "postgres",
  database: "undi_online_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  queue_target: 5000,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :undi_online, UndiOnlineWeb.Endpoint,
  http: [port: 4002],
  server: true

# In test we don't send emails.
config :undi_online, UndiOnline.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

config :undi_online,
  stripe_service: MockStripe,
  require_subscription: false,
  require_user_confirmation: false

# Recommended to lower the iterations count in
# your test environment to speed up your tests
config :bcrypt_elixir, :log_rounds, 1

config :undi_online, UndiOnline.Admins.Guardian,
  issuer: "undi_online",
  secret_key: "1RCGH+jnTgJNVrkKQMrebh6AOkYRLrpThEPM37fEIYHXtJCEvwAjdQwbRLv8GPWJ"

config :undi_online, UndiOnline.Accounts.Guardian,
  issuer: "undi_online",
  secret_key: "hS5jzOOsnvcmGvhz6B1B+FfbtfKY2wvTxYSLC6CcC8WY2pNLsx59nEPwWOnwIAHL"

config :undi_online, Oban, queues: false, plugins: false
config :wallaby, otp_app: :undi_online
config :undi_online, :sandbox, Ecto.Adapters.SQL.Sandbox
