defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    flatten_rec([], list)
  end

  defp flatten_rec(new_list, list) do
    case list do
      x when x in [nil, []] -> new_list

      [first | rest] ->
        flatten_rec(new_list, first) \
        |> flatten_rec(rest)

      _ -> new_list ++ [list]
    end
  end
end
