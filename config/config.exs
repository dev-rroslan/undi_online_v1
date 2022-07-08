# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :undi_online,
  ecto_repos: [UndiOnline.Repo],
  generators: [binary_id: true]

config :undi_online, UndiOnline.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

config :undi_online,
  stripe_service: Stripe,
  require_subscription: false,
  require_user_confirmation: true,
  app_name: "UndiOnline",
  page_url: "undi_online.com",
  company_name: "UndiOnline Inc",
  company_address: "26955 Fritsch Bridge",
  company_zip: "54933-7180",
  company_city: "San Fransisco",
  company_state: "California",
  company_country: "United States",
  contact_name: "John Doe",
  contact_phone: "+1 (335) 555-2036",
  contact_email: "john.doe@undi_online.com",
  from_email: "john.doe@undi_online.com"

# Configures the endpoint
config :undi_online, UndiOnlineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5TfKFFYs7Ds1ojD7kAttEXxtI0zlKBLzwslLc/sDbhXD/7DbqGHWsgK9WzeS1JFc",
  render_errors: [view: UndiOnlineWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UndiOnline.PubSub,
  live_view: [signing_salt: "IfTy4HPe"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.26",
  default: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.0.18",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :undi_online, UndiOnline.Mailer, adapter: Swoosh.Adapters.Local

# Used for using a local client like Mailcatcher
# Mailcatcher is great when testing the emails in IEX
# config :undi_online, UndiOnline.Mailer,
#   adapter: Swoosh.Adapters.SMTP,
#   relay: "127.0.0.1",
#   port: 1025

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :stripity_stripe,
  api_key: System.get_env("STRIPE_SECRET"),
  public_key: System.get_env("STRIPE_PUBLIC"),
  webhook_signing_key: System.get_env("STRIPE_WEBHOOK_SIGNING_KEY")

config :undi_online, UndiOnline.Admins.Guardian,
  issuer: "undi_online",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY_ADMINS") || "MxEKXj+V7tp+Yihf1COFsI+HI5C1fI4tZ7Xo3ZRHm32ldP8GHP6AqrnlKcG03DHl"

config :undi_online, UndiOnline.Accounts.Guardian,
  issuer: "undi_online",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "2umMb0D0KtMYDQ52bclpY6OPlwdEmKXg8IjmrEIxdTXNffMMpVBe4HtfgLdel03y"

config :undi_online, Oban,
  repo: UndiOnline.Repo,
  queues: [default: 10, mailers: 20, high: 50, low: 5],
  plugins: [
    {Oban.Plugins.Pruner, max_age: (3600 * 24)},
    {Oban.Plugins.Cron,
      crontab: [
       # {"0 2 * * *", UndiOnline.Workers.DailyDigestWorker},
       {"@reboot", UndiOnline.Workers.StripeSyncWorker}
     ]}
  ]

config :saas_kit,
  otp_app: :undi_online,
  main_module: UndiOnline,
  api_key: System.get_env("SAAS_KIT_API_KEY")

config :undi_online, :env, Mix.env()

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
