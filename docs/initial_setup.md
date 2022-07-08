# Initial Setup

## Basic Setup

Update settings with your company settings. This should be reflected in different templates
and emails.

```elixir
# config.exs

config :undi_online,
  stripe_service: Stripe,
  require_subscription: true,
  page_name: "my-app.com",
  company_name: "My App Inc",
  company_address: "26955 Fritsch Bridge",
  company_zip: "54933-7180",
  company_city: "San Fransisco",
  company_state: "California",
  company_country: "United States",
  contact_name: "John Doe",
  contact_phone: "+1 (335) 555-2036",
  contact_email: "contact@my-app.com"
```

## .env

```elixir
# .env
export STRIPE_SECRET=sk_test_51KO03cFIjONIzI1y6bfrrHx6DHPGBYZ5Q8U6FcjNdnaeanJKzGDs1IniENXHJRjrnqw37yJLPxyOfA9C3PHcn9lz00Zt432c2V
export STRIPE_PUBLIC=pk_test_51KO03cFIjONIzI1yWMbul4VsBmjI3f65qLL0NnU1c7TeZ6KsSceA1CF3iWqjJ8dYmE0NLjAPQO11LBFpXRQ0qctV00PIs3f4d6
export STRIPE_WEBHOOK_SIGNING_KEY=
export GUARDIAN_SECRET_KEY=ta26YfyU6bAuge4Ee3fww9Y6rCWsQIPRFNyvCS3ilE0rtpcuOizVbQhxzZxFbm/T
export GUARDIAN_SECRET_KEY_ADMINS=
```

Generate the GUARDIAN_SECRET_KEY with:

```elixir
mix guardian.gen.secret
```

## Add administrator

Generate an administrator with the command:

```elixir
mix generate_admin email@example.com
```

And then go the login page

```elixir
http://localhost:4000/admin/sign_in
```

You can either login with the email and password or ask for a magin login
link that will be sent to the admin email.

```elixir
http://localhost:4000/admin/reset_password
```
