defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    {a, b, c} = {rem(number, 3), rem(number, 5), rem(number, 7)}
    cond do
      a == 0 and b == 0 and c == 0 ->
        "PlingPlangPlong"

      a == 0 and b == 0 ->
        "PlingPlang"

      b == 0 and c == 0 ->
        "PlangPlong"

      a == 0 and c == 0 ->
        "PlingPlong"

      a == 0 ->
        "Pling"

      b == 0 ->
        "Plang"

      c == 0 ->
        "Plong"

      true -> Integer.to_string(number)
    end
  end
end
