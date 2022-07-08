defmodule UndiOnline.NotificationsTest do
  use UndiOnline.DataCase, async: true

  import UndiOnline.AccountsFixtures

  alias UndiOnline.Notifications

  test "signup" do
    user = user_fixture()

    assert Notifications.signup(user) == :ok

    assert [%UndiOnline.InAppNotifications.Notification{}] =
             UndiOnline.InAppNotifications.list_notifications(user)
  end
end
