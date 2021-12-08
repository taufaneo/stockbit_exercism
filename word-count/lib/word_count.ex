defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    word_map = %{}
    String.split(sentence, ["\n", "\t", " ", "_", ",", "."]) \
    |> Enum.map(fn word -> String.downcase(word) end) \
    |> Enum.map(fn word -> ignore_punctuation(word) end) \
    |> Enum.reduce(word_map, fn (el, word_map) ->
      case Map.get(word_map, el) do
        nil ->
          if el != "" do
            Map.put(word_map, el, 1)
          else
            word_map
          end
        x -> Map.put(word_map, el, x + 1)
      end
    end)
  end

  defp ignore_punctuation(word) do
    ignore_punc_rec(word) \
    |> String.reverse() \
    |> ignore_punc_rec() \
    |> String.reverse()
  end

  defp ignore_punc_rec(word) do
    case word do
      "" -> word

      <<first::utf8, rest::binary>> ->
        case first do
          x when x in 33..47 or x in 58..64 or x in 91..96 or x in 123..126 ->
            ignore_punc_rec(rest)

          _ -> word
        end
    end
  end
end
