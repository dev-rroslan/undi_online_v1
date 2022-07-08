defmodule UndiOnline.Mailer do
  use Swoosh.Mailer, otp_app: :undi_online

  def deliver_later(email) do
    deliver(email)
  end
end
