defmodule UndiOnline.Admins.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :undi_online,
    error_handler: UndiOnline.Admins.ErrorHandler,
    module: UndiOnline.Admins.Guardian

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true

  # Set current admin
  plug UndiOnlineWeb.Plugs.SetCurrentAdmin

  # Set current admin account - when using account swithcher in admin
  plug UndiOnlineWeb.Plugs.SetCurrentAdminAccount
end
