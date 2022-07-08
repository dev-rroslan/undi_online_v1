defmodule UndiOnlineWeb.App.BillingLive.Index do
  use UndiOnlineWeb, :live_view

  import UndiOnlineWeb.Views.DateHelpers
  import UndiOnlineWeb.Views.NumberHelpers

  alias UndiOnline.Billing

  @stripe_service Application.get_env(:undi_online, :stripe_service)

  on_mount UndiOnlineWeb.App.InitAssigns

  @impl true
  def mount(_params, _session, socket) do
    account = socket.assigns.account

    {
      :ok,
      socket
      |> assign(:invoices, load_invoices(account))
      |> assign(:billing_customer, load_billing_customer(account))
    }
  end

  @impl true
  def handle_event("payment-method-created", %{"id" => payment_method_id}, socket) do
    customer = socket.assigns.billing_customer
    create_and_attach_payment_method(customer.stripe_id, payment_method_id)
    account = UndiOnline.Accounts.get_account!(socket.assigns.account.id)

    {
      :noreply,
      socket
      |> assign(:account, account)
      |> push_event("close", %{id: "edit-card-modal"})
      |> put_flash(:info, "Card information was updated")
    }
  end

  def handle_event("is-loading", %{"loading" => _loading}, socket) do
    {:noreply, socket}
  end

  defp create_and_attach_payment_method(customer_stripe_id, payment_method_id) do
    {:ok, payment_method} =
      @stripe_service.PaymentMethod.attach(%{
        customer: customer_stripe_id,
        payment_method: payment_method_id
      })

    @stripe_service.Customer.update(customer_stripe_id, %{
      invoice_settings: %{default_payment_method: payment_method.id}
    })
  end

  defp load_invoices(account) do
    Billing.list_invoices_for_account(account.id)
  end

  defp load_billing_customer(account) do
    Billing.get_billing_customer_for_account(account)
  end
end
