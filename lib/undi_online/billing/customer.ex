defmodule UndiOnline.Billing.Customer do
  use UndiOnline.Schema
  import Ecto.Changeset

  schema "billing_customers" do
    field :stripe_id, :string

    belongs_to :account, UndiOnline.Accounts.Account
    has_many :subscriptions, UndiOnline.Billing.Subscription
    has_many :invoices, UndiOnline.Billing.Invoice

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:stripe_id])
    |> validate_required([:stripe_id])
    |> unique_constraint(:stripe_id, name: :billing_customers_stripe_id_index)
  end
end
