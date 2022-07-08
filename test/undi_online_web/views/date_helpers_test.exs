defmodule UndiOnlineWeb.Views.DateHelpersTest do
  use UndiOnlineWeb.ConnCase, async: true

  alias UndiOnlineWeb.Views.DateHelpers

  describe "human_date" do
    test "returns a correctly formatted date for current year" do
      current_year = NaiveDateTime.utc_now().year
      date_time = NaiveDateTime.new!(current_year, 4, 11, 15, 0, 0)

      assert DateHelpers.human_date(date_time) == "11 Apr"
    end

    test "returns a correctly formatted date for a past year" do
      assert DateHelpers.human_date(~N[2000-01-01 23:00:07]) == "01 Jan - 2000"
    end

    test "returns nil if a date is not provided" do
      assert DateHelpers.human_date(nil) == nil
    end
  end
end
