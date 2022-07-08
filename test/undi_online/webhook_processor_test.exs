defmodule UndiOnline.Billing.WebhookProcessorTest do
  use UndiOnline.DataCase

  @stripe_service Application.get_env(:undi_online, :stripe_service)

  alias UndiOnline.Billing.WebhookProcessor
  alias UndiOnlineWeb.StripeWebhookController

  def event_fixture(attrs \\ %{}) do
    @stripe_service.Event.generate(attrs)
  end

  describe "listen for and processing a stripe event" do
    test "processes incoming events after broadcasing it" do
      start_supervised(WebhookProcessor, [])
      WebhookProcessor.subscribe()

      event = event_fixture()
      StripeWebhookController.notify_subscribers(event)

      assert_receive {:event, _}
    end
  end
end
