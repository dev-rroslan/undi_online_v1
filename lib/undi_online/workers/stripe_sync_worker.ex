defmodule UndiOnline.Workers.StripeSyncWorker do
  @moduledoc """
  Syncs products and plans with Stripe
  """
  use Oban.Worker

  alias UndiOnline.Billing.SynchronizeProducts
  alias UndiOnline.Billing.SynchronizePlans

  @impl Oban.Worker
  def perform(_job) do
    case Application.fetch_env(:stripity_stripe, :api_key) do
      {:ok, _ } ->
        SynchronizeProducts.run()
        SynchronizePlans.run()
      _ ->
        nil
    end

    :ok
  end
end
