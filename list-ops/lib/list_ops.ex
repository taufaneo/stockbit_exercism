defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    case l do
      [] -> 0
      [_ | rest] -> 1 + count(rest)
    end
  end

  @spec reverse(list) :: list
  def reverse(l) do
    case l do
      [] -> l
      [first | rest] -> append(reverse(rest), [first])
    end
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    case l do
      [] -> l
      [first | rest] ->
        append([f.(first)], map(rest, f))
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    case l do
      [] -> l
      [first | rest] ->
        cond do
          f.(first) ->
            append([first], filter(rest, f))

          true ->
            filter(rest, f)
        end
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f) do
    case l do
      [] -> acc
      [first | rest] ->
        foldl(rest, f.(first, acc), f)
    end
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    case l do
      [] -> acc
      [first | rest] ->
        f.(first, foldr(rest, acc, f))
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    case a do
      [] -> b
      [first | rest] -> [first | append(rest, b)]
    end
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    concat_rec(ll, [])
  end

  defp concat_rec(lists, new_list) do
    case lists do
      [] -> new_list

      [first | rest] ->
        concat_rec(rest,
          case first do
            [] -> new_list

            [first_head | first_tail] ->
              concat_rec([first_tail], append(new_list, [first_head]))
              
            n -> append(new_list, [n])
          end)
    end
  end
end
