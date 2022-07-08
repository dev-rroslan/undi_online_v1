defmodule UndiOnlineWeb.Admin.InvoiceLive.Index do
  use UndiOnlineWeb, :live_view_admin
  use Saas.DataTable

  import UndiOnlineWeb.Views.DateHelpers
  import UndiOnlineWeb.Views.NumberHelpers

  alias UndiOnline.Billing

  @impl true
  def mount(params, _session, socket) do
    {:ok, assign(socket, get_invoices_assigns(params))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {
      :noreply,
      socket
      |> assign(:params, params)
      |> assign(:page_title, "Listing Invoices")
      |> assign(get_invoices_assigns(params))
    }
  end

  defp get_invoices_assigns(params) do
    case Billing.paginate_invoices(params) do
      {:ok, assigns} -> assigns
      _ -> %{}
    end
  end
end
