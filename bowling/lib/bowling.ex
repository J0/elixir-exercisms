defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  defstruct rolls: []
  @min_roll 0
  @max_roll 10

  @spec start() :: any
  def start do
    %__MODULE__{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  def roll(_game, roll) when roll < @min_roll, do: {:error, "Negative roll is invalid"}

  def roll(_game, roll) when roll > @max_roll, do: {:error, "Pin count exceeds pins on the lane"}

  @spec roll(any, integer) :: any | String.t()
  def roll(game, roll) do
    %{game | rolls: game.rolls ++ [roll]}
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(game) do
    Enum.sum(game.rolls)
  end
end
