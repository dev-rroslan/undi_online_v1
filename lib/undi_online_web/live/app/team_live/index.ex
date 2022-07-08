defmodule UndiOnlineWeb.App.TeamLive.Index do
  use UndiOnlineWeb, :live_view

  alias UndiOnline.Accounts

  on_mount UndiOnlineWeb.App.InitAssigns

  @impl true
  def mount(_params, _session, socket) do
    users = Accounts.list_users(socket.assigns.account)

    {
      :ok,
      socket
      |> assign(:users, users)
    }
  end
end
