defmodule UndiOnline.InAppNotifications.Flash do
  use UndiOnline.Schema

  embedded_schema do
    field :type, :string, default: "info"
    field :title, :string
    field :body, :string
    field :closable, :boolean, default: true
  end

  # def notify(body) do
  #   Phoenix.PubSub.broadcast(UndiOnline.PubSub, "flash_notification", {:notify, body})
  # end
  #
  # def subscribe do
  #   Phoenix.PubSub.subscribe(UndiOnline.PubSub, "flash_notification")
  # end
end
