defmodule TwitterSimWeb.SignupController do
  use TwitterSimWeb, :controller
import Ecto.Query, warn: false
  alias TwitterSim.Tweeter
  alias TwitterSim.Repo
  alias TwitterSim.Usage

  def new(conn, _) do
    render(conn, "signup.html")
  end

     def simulate(conn, _pa) do
       render(conn, "simulate.html")
     end

  def create(conn, info) do#%{"handle" => handle, "crypto_pass" => crypto_pass}) do
    IO.inspect info
    {status, _} = %Tweeter{} |> Tweeter.changeset(info) |> Repo.insert()
    if status == :ok, do: conn |> put_flash(:info, "You have successfully registered. Please sign in with you newly created login details") |> redirect(to: Routes.usage_path(conn, :new)),
    else: conn |> put_flash(:error, "Registration failed") |> redirect(to: Routes.signup_path(conn, :new))
  end

  def insert(conn, info) do#%{"handle" => handle, "crypto_pass" => crypto_pass}) do
    IO.inspect info["numUsers"]
    #numUsers = info["numUsers"] |> String.to_integer()
    #usernames = for x<- numUsers, do: "test"<>Integer.to_string(x)
    #passwords = for x<-numUsers, do: "test"<>Integer.to_string(x)
    #infos = for x<-numUsers do
    #           Map.put(info,"crypto_pass", Enum.at(passwords,x))
    #           Map.put(info, "handle", Enum.at(passwords,x))
    #        end

    #IO.inspect infos
    #{status, _} = %Tweeter{} |> Tweeter.changeset(info) |> Repo.insert()
    #if status == :ok, do: conn |> put_flash(:info, "You have successfully registered. Please sign in with you newly created login details") |> redirect(to: Routes.usage_path(conn, :new)),
    #else: conn |> put_flash(:error, "Registration failed") |> redirect(to: Routes.signup_path(conn, :new))
    conn |> put_flash(:info, "You have successfully registered. Please sign in with you newly created login details") |> redirect(to: Routes.signup_path(conn, :simulate))
  end
end
