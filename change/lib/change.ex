defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    result = Enum.reverse(coins) \
             |> make_change(target, []) \
             |> find_least_coins([]) \
             |> Enum.sort()
    
    cond do
      result == [] and target != 0 -> {:error, "cannot change"}
      true -> {:ok, result}
    end
  end

  def make_change(coins, target, changes) do
    cond do
      target < 0 ->
        []
      target == 0 ->
        changes
      target > 0 ->
        Enum.map(coins, fn c ->
          make_change(coins, target - c, changes ++ [c])
        end)
    end
  end

  def find_least_coins(tree, least_coins) do
    case tree do
      [] -> least_coins
      [first | rest] -> 
        left = cond do
          is_list(first) -> find_least_coins(first, least_coins)
          true -> tree
        end
        right = find_least_coins(rest, least_coins)
        _least =
          cond do
            length(left) == 0 and length(right) == 0 -> []
            length(left) == 0 -> right
            length(right) == 0 -> left
            true ->
              sum_left = Enum.reduce(left, 0, fn (x, acc) -> x+acc end)
              sum_right = Enum.reduce(right, 0, fn(x, acc) -> x+acc end)
              cond do
                sum_left > sum_right -> left
                sum_right > sum_left -> right
                true -> 
                  cond do
                    length(left) < length(right) -> left
                    true -> right
                  end
              end
          end
    end
  end 
end
