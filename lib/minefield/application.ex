defmodule Minefield.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    configure_device(target())

    opts = [strategy: :one_for_one, name: Minefield.Supervisor]
    children =
      [] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  def configure_device(:host), do: :no_device
  def configure_device(_target) do
    Minefield.Usb.Gadget.configure_device()
  end

  def children(:host) do
    []
  end

  def children(_target) do
    []
  end

  def target() do
    Application.get_env(:minefield, :target)
  end
end
