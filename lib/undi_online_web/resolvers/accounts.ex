defmodule UndiOnlineWeb.Resolvers.Accounts do
  alias UndiOnline.Accounts
  alias UndiOnline.Accounts.User

  def list_users(_args, %{context: %{current_account: account}}) do
    {:ok, Accounts.list_users(account)}
  end

  def list_users(_args, _context), do: {:error, "Not Authorized"}

  def get_user(%{id: id}, %{context: %{current_account: account}}) do
    {:ok, Accounts.get_user!(account, id)}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def get_user(_args, _context), do: {:error, "Not Authorized"}

  def login(%{email: email, password: password}, _info) do
    with %User{} = user <- Accounts.get_user_by_email_and_password(email, password),
         {:ok, jwt, _full_claims} <- UndiOnline.Accounts.Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    else
      _ -> {:error, "Incorrect email or password"}
    end
  end
end
