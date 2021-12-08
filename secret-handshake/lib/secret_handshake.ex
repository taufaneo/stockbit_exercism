defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code > 0 and code < 32 do
    dec2bin(code, 1) \
    |> ignore_zero_element() \
    |> transform_secret()
  end

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code <=0 or code >= 32 do
    []
  end

  defp dec2bin(dec, nbz) do
    case div(dec, 2) do
      0 -> ["1"]
      1 ->
        [Integer.to_string(rem(dec, 2)) <> \
          String.duplicate("0", nbz-1),
          "1" <> String.duplicate("0", nbz)]
      n ->
        [Integer.to_string(rem(dec, 2)) <> \
          String.duplicate("0", nbz-1)] ++ dec2bin(n, nbz+1)
    end
  end

  defp ignore_zero_element(list) do
    case list do
      [] -> list
      [first | rest] ->
        case String.at(first, 0) do
          "0" -> ignore_zero_element(rest)
          "1" -> [first] ++ ignore_zero_element(rest)
        end
    end
  end

  defp transform_secret(list) do
    cond do
      Enum.member?(list, "10000") ->
        [_ | rest] = Enum.reverse(list)
        transform_secret(rest)

      true ->
        case list do
          [] -> list
          [first | rest] ->
            case first do
              "1" ->
                ["wink"]
              "10" ->
                ["double blink"]
              "100" ->
                ["close your eyes"]
              "1000" ->
                ["jump"]
            end
            ++ transform_secret(rest)
        end
    end
  end
end
