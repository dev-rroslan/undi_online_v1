defmodule UndiOnlineWeb.Live.Admin.Components.AdminComponents do
  defmacro __using__(_opts) do
    quote do
      import UndiOnlineWeb.Live.Admin.Components.ModalComponent
    end
  end
end
