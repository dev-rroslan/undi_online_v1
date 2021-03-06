defmodule UndiOnlineWeb.App.Notifications.IndicatorLive do
  use Phoenix.LiveView,
    namespace: UndiOnlineWeb,
    container: {:div, class: "flex items-center"}

  on_mount UndiOnlineWeb.App.InitAssigns

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.user
    UndiOnline.InAppNotifications.subscribe_on_notification_created(user.id)

    {
      :ok,
      socket
      |> assign(:notifications, get_notifications(user))
    }
  end

  @impl true
  def handle_info(%{notification: notification}, socket) do
    {:noreply, assign(socket, :notifications, [notification | socket.assigns.notifications])}
  end
  def handle_info(_, socket), do: {:noreply, socket}

  defp get_notifications(nil), do: []

  defp get_notifications(user) do
    UndiOnline.InAppNotifications.list_notifications_for_menu(user)
  end
end
