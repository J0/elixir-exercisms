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

  def simulate(robot, "") do
    robot
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    case instructions do
      "R" <> rest -> right_action(robot, rest)
      "L" <> rest -> left_action(robot, rest)
      "A" <> rest -> advance_action(robot, rest)
      _ -> {:error, "invalid instruction"}
    end
  end

  defp right_action(robot, rest) do
    robot = %{robot | direction: change_direction_from_right(robot)}
    simulate(robot, rest)
  end

  defp left_action(robot, rest) do
    robot = %{robot | direction: change_direction_from_left(robot)}
    simulate(robot, rest)
  end

  defp advance_action(robot, rest) do
    robot = update_position(robot)
    simulate(robot, rest)
  end

  @doc """
  Update the robot's direction
  """
  @spec change_direction_from_left(direction :: map()) :: map()
  def change_direction_from_left(robot) do
    cond do
      robot.direction == :north -> :west
      robot.direction == :east -> :north
      robot.direction == :south -> :east
      robot.direction == :west -> :south
    end
  end

  def change_direction_from_right(robot) do
    cond do
      robot.direction == :north -> :east
      robot.direction == :east -> :south
      robot.direction == :south -> :west
      robot.direction == :west -> :north
    end
  end

  @doc """
  Update the robot's position
  """
  @spec update_position(robot :: map()) :: map()
  def update_position(robot) do
    pos = robot.position

    case robot.direction do
      :north -> %{robot | position: {elem(pos, 0), elem(pos, 1) + 1}}
      :south -> %{robot | position: {elem(pos, 0), elem(pos, 1) - 1}}
      :east -> %{robot | position: {elem(pos, 0) + 1, elem(pos, 1)}}
      :west -> %{robot | position: {elem(pos, 0) - 1, elem(pos, 1)}}
    end
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
