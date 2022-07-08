defmodule UndiOnlineWeb.App.HomeLive do
  use UndiOnlineWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
