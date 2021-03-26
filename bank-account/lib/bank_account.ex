defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = start_link()
    pid
  end

  def start_link do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_), do: {:ok, 0}

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :balance)
    else
      {:error, :account_closed}
    end
  end

  def handle_call(:balance, _, state) do
    {:reply, state, state}
  end

  def handle_call({:update, amount}, _, state) do
    {:reply, state, state + amount}
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    if Process.alive?(account) do
      GenServer.call(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end
end
