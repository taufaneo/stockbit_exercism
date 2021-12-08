defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = trim_space(input) \
            |> String.reverse() \
            |> trim_space() \
            |> String.reverse()

    cond do
      String.ends_with?(input, "?") ->
        cond do
          yell?(input) \
          and not non_letters_only?(input) \
          and not numbers_only?(input) ->
            "Calm down, I know what I'm doing!"
          true ->
            "Sure."
        end

      nothing?(input) ->
        "Fine. Be that way!"

      yell?(input) and not numbers_only?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp trim_space(input) do
    case input do
      "" -> input
      <<first::utf8, rest::binary>> ->
        cond do
          space?(first) -> trim_space(rest)
          true -> input
        end
    end
  end

  defp yell?(input) do
    case input do
      "" -> true
      <<first::utf8, rest::binary>> ->
        cond do
          lowcase?(first) -> false
          true -> true
        end
        and
        yell?(rest)
    end
  end

  defp numbers_only?(input) do
    case input do
      "" -> true
      <<first::utf8, rest::binary>> ->
        cond do
          numchar?(first) -> true
          punctuation?(first) -> true
          space?(first) -> true
          true-> false
        end
        and
        numbers_only?(rest)
    end
  end
  
  defp non_letters_only?(input) do
    case input do
      "" -> true
      <<first::utf8, rest::binary>> ->
        cond do
          punctuation?(first) -> true
          space?(first) -> true
          special_char?(first) -> true
          true -> false
        end
        and
        non_letters_only?(rest)
    end
  end

  defp space?(char) do
    case char do
      x when x in ' ' -> true
      _ -> false
    end
  end

  defp punctuation?(char) do
    case char do
      x when x in '!?,.\'' -> true
      _ -> false
    end
  end

  defp special_char?(char) do
    case char do
      x when x in '@#$%^&*<>():;|[]{}-_=+' -> true
      _ -> false
    end
  end

  defp numchar?(char) do
    case char do
      x when x in 48..57 -> true
      _ -> false
    end
  end

  defp lowcase?(char) do
    case char do
      x when x in 97..122 -> true
      _ -> false
    end
  end

  defp nothing?(input) do
    String.split(input, [" ", "\n", "\t", "\r"]) \
    |> Enum.reduce(true, fn (x, acc) ->
      case x do
        "" -> true
        _ -> false
      end
      and acc
    end)
  end
end
