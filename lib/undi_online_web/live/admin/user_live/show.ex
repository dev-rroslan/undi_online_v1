defmodule UndiOnlineWeb.Admin.UserLive.Show do
  use UndiOnlineWeb, :live_view_admin

  alias UndiOnline.Accounts

  on_mount {UndiOnlineWeb.Admin.InitAssigns, :require_account}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    account = socket.assigns.account

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, Accounts.get_user!(account, id))}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
