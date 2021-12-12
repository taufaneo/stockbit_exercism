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
  def generate(_coins, target) when target < 0 do
    {:error, "cannot change"}
  end

  def generate(_coins, target) when target == 0 do
    {:ok, []}
  end

  def generate(coins, target) do
    change_map = 1..target
      |> Enum.reduce(
        %{0 => []},
        fn idx, acc ->
          build_changes(coins, idx, acc)
        end)
    result = Map.get(change_map, target)
    cond do
      result == nil and result != [] -> {:error, "cannot change"}
      true -> {:ok, result}
    end
  end

  def build_changes(coins, idx, acc) do
    change_list = coins
      |> Enum.filter(fn coin -> acc[idx-coin] end)
      |> Enum.map(fn coin ->
          list = acc[idx-coin]
          if coin + Enum.sum(list) == idx do
            [coin | list]
          else
            []
          end
        end)
      |> collect_sort([]) 
      |> remove_duplicates([])
      |> remove_empty([])
      |> least_number_of_elements()
    Map.put(acc, idx, change_list)
  end

  def collect_sort(lol, new_lol) do
    case lol do
      [] -> new_lol
      [first | rest] ->
        cond do
          is_list(first) ->
            collect_sort(first, new_lol) ++ collect_sort(rest, new_lol)
          true ->
            [Enum.sort(lol) | new_lol]
        end
    end
  end

  defp remove_duplicates(list, new_list) do
    case list do
      [] -> new_list
      [first | rest] ->
        remove_duplicates(rest,
          cond do
            Enum.member?(new_list, first) ->
              new_list
            true ->
              new_list ++ [first]
          end)
    end
  end

  defp remove_empty(lol, new_lol) do
    case lol do
      [] -> new_lol
      [first | rest] -> 
        remove_empty(rest,
          cond do
            first == [] or first == [nil] -> new_lol
            true ->
              new_lol ++ [first]
          end)
    end
  end

  defp least_number_of_elements(lol) do
    case lol do
      [] -> nil
      [first | rest] ->
        least_between_two(first, least_number_of_elements(rest))
    end
  end

  defp least_between_two(list1, list2) when list2 == nil do
    list1
  end

  defp least_between_two(list1, list2) when list2 != nil do
    if Enum.count(list1) <= Enum.count(list2) do
        list1
    else
      list2
    end
  end
end
