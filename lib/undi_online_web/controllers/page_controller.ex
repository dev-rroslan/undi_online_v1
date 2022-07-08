defmodule UndiOnlineWeb.PageController do
  use UndiOnlineWeb, :controller

  @app_name Application.get_env(:undi_online, :app_name)
  @company_name Application.get_env(:undi_online, :company_name)

  def privacy(conn, _params) do
    render(conn, "privacy.html", app_name: @app_name, company_name: @company_name)
  end

  def terms(conn, _params) do
    render(conn, "terms.html", app_name: @app_name, company_name: @company_name)
  end
end
