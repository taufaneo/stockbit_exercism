defmodule RobotSimulator do

  defstruct [
    position: {0, 0},
    direction: :north
  ]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil) do
    cond do
      direction != nil and position != nil ->
        if valid_direction?(direction) do
          if valid_position?(position) do
            %RobotSimulator{direction: direction, position: position}
          else
            {:error, "invalid position"}
          end
        else
          {:error, "invalid direction"}
        end

      direction != nil and position == nil ->
        {:error, "invalid position"}

      direction != nil ->
        if valid_direction?(direction) do
          %RobotSimulator{direction: direction}
        else
          {:error, "invalid direction"}
        end

      position != nil and direction == nil->
        {:error, "invalid direction"}

      position != nil ->
        if valid_position?(position) do
          %RobotSimulator{position: position}
        else
          {:error, "invalid position"}
        end

      true ->
        %RobotSimulator{}  
    end
  end


  defp valid_direction?(direction) do
    cond do
      direction in [:north, :east, :south, :west] -> true
      true -> false
    end
  end

  defp valid_position?(p) do
    cond do
      is_tuple(p) and \
      tuple_size(p) == 2 and \
      is_integer(elem(p, 0)) and \
      is_integer(elem(p, 1)) -> true
        
      true -> false
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    ins = String.graphemes(instructions)
    if valid_instructions(ins) do
      execute_instructions(robot, ins)
    else
      {:error, "invalid instruction"}
    end
  end

  defp valid_instructions(ins) do
    case ins do
      [] -> true
      [first | rest] ->
        if first in ["L", "R", "A"] do
          true
        else
          false
        end
        and
        valid_instructions(rest)
    end
  end

  defp execute_instructions(robot, ins) do
    case ins do
      [] -> robot
      [first | rest] ->
        execute_instructions(
          case first do
            "L" -> turn_left(robot)
            "R" -> turn_right(robot)
            "A" -> advance(robot)
          end, rest)
    end
  end

  defp turn_left(robot) do
    case direction(robot) do
      :north -> %RobotSimulator{robot | direction: :west}
      :west -> %RobotSimulator{robot | direction: :south}
      :south -> %RobotSimulator{robot | direction: :east}
      :east -> %RobotSimulator{robot | direction: :north}
    end
  end

  defp turn_right(robot) do
    case direction(robot) do
      :north -> %RobotSimulator{robot | direction: :east}
      :east -> %RobotSimulator{robot | direction: :south}
      :south -> %RobotSimulator{robot | direction: :west}
      :west -> %RobotSimulator{robot | direction: :north}
    end
  end

  defp advance(robot) do
    case direction(robot) do
      :north -> %RobotSimulator{robot | position: 
          {elem(robot.position, 0), elem(robot.position, 1) + 1}}
      :east -> %RobotSimulator{robot | position: 
          {elem(robot.position, 0) + 1, elem(robot.position, 1)}} 
      :south -> %RobotSimulator{robot | position: 
          {elem(robot.position, 0), elem(robot.position, 1) - 1}} 
      :west -> %RobotSimulator{robot | position: 
          {elem(robot.position, 0) - 1, elem(robot.position, 1)}}
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
