defmodule UndiOnline.EmailsTest do
  use UndiOnline.DataCase, async: true

  alias UndiOnline.Emails

  @from Application.get_env(:undi_online, :from_email)

  test "welcome email" do
    user = %{name: "John Doe", email: "john.doe@example.com"}

    email = Emails.welcome_email(user)

    assert email.to == [{"", "john.doe@example.com"}]
    assert email.from == {"", @from}
    assert email.html_body =~ "Welcome"
    assert email.text_body =~ "Welcome"
  end

  test "admin login link email" do
    message = %{url: ~s(#somelinkwithtoken), email: "john.doe@example.com"}

    email = Emails.admin_login_link(message)

    assert email.to == [{"", "john.doe@example.com"}]
    assert email.from == {"", @from}
    assert email.html_body =~ "href=\"#somelinkwithtoken\""
  end

  test "invite user email" do
    message = %{url: ~s(#somelinkwithtoken), email: "john.doe@example.com"}

    email = Emails.invite_user_email(message)

    assert email.to == [{"", "john.doe@example.com"}]
    assert email.from == {"", @from}
    assert email.html_body =~ "href=\"#somelinkwithtoken\""
  end
end
