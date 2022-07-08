defmodule UndiOnlineWeb.Admin.SettingLive.Edit do
  use UndiOnlineWeb, :live_view_admin

  alias UndiOnline.Admins

  @impl true
  def mount(_params, %{"current_admin_id" => id}, socket) do
    admin = Admins.get_admin!(id)

    {
      :ok,
      socket
      |> assign(:page_title, "Settings")
      |> assign(:admin, admin)
    }
  end
end
