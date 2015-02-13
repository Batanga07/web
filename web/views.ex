defmodule Entice.Web.View do
  use Phoenix.View, namespace: Entice.Web, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import Entice.Web.Router.Helpers
      import Entice.Web.Client

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML
    end
  end

  # Functions defined here are available to all other views/templates
  def title, do: "... entice server ..."

  def email(conn), do: Plug.Conn.get_session(conn, :email)
end
