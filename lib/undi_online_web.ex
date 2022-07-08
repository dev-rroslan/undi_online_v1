defmodule UndiOnlineWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use UndiOnlineWeb, :controller
      use UndiOnlineWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: UndiOnlineWeb

      import Plug.Conn
      import UndiOnlineWeb.Gettext
      alias UndiOnlineWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/undi_online_web/templates",
        namespace: UndiOnlineWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {UndiOnlineWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  # Used for admin area.
  def live_view_admin do
    quote do
      use Phoenix.LiveView,
        layout: {UndiOnlineWeb.Admin.LayoutView, "live.html"}

      use UndiOnlineWeb.Live.Admin.Components.AdminComponents

      unquote(view_helpers())
    end
  end

  def live_view_no_layout do
    quote do
      use Phoenix.LiveView

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import UndiOnlineWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers
      import UndiOnlineWeb.LiveHelpers
      alias Phoenix.LiveView.JS

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import UndiOnlineWeb.ErrorHelpers
      import UndiOnlineWeb.Gettext
      alias UndiOnlineWeb.Router.Helpers, as: Routes

      import UndiOnlineWeb.Views.AppInfo
      import UndiOnlineWeb.SharedComponents
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
