defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      is_valid_position?(position) and is_valid_direction?(direction) ->
        %{direction: direction, position: position}

      is_valid_position?(position) ->
        {:error, "invalid direction"}

      is_valid_direction?(direction) ->
        {:error, "invalid position"}

      true ->
        {:error, "check logs"}
    end
  end

  def is_valid_position?({x, y} = position) do
    is_integer(x) and is_integer(y) and tuple_size(position) == 2
  end

  def is_valid_position?(_), do: false

  def is_valid_direction?(direction) do
    direction in [:north, :south, :east, :west]
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    # Enum.each() -> Loop over all characters in the
    # case instructions do
    #   "R" <> _ -> change_direction(robot.direction) and update_position(robot.position)
    #   "L" <> _ -> change_direction(robot.direction) and update_position(robot.position)
    #   "A" <> rest -> change_direction(robot.direction) and update_position(robot.position)
    # end
  end

  @doc """
  Update the robot's direction
  """
  @spec change_direction(direction :: atom)
  def change_direction do
  end

  @doc """
  Update the robot's position
  """
  @spec update_position(position :: map())
  def update_position do
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
