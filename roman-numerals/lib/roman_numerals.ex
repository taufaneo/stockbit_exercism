defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    case div(number, 1000) do
      n when n >= 1 ->
        String.duplicate("M", n) <> numeral(rem(number, 1000))

      n when n < 1 ->
        case div(number, 500) do
          x when x >= 1 and number >= 900 ->
            "CM" <> numeral(rem(number, 100))

          x when x >= 1 and number < 900 ->
            "D" <> String.duplicate("C", div(rem(number, 500), 100)) \
            <> numeral(rem(number, 100))

          x when x < 1 and number >= 400 ->
            "CD" <> numeral(rem(number, 100))

          x when x < 1 and number >= 100 ->
            String.duplicate("C", div(number, 100)) \
            <> numeral(rem(number, 100))

          _ when number < 100 ->
            case div(number, 50) do
              p when p >= 1 and number >= 90 ->
                "XC" <> numeral(rem(number, 10))

              p when p >= 1 and number < 90 ->
                "L" <> String.duplicate("X", div(rem(number, 50), 10)) \
                <> numeral(rem(number, 10))

              p when p < 1 and number >= 40 ->
                "XL" <> numeral(rem(number, 10))

              p when p < 1 and number >= 10 ->
                String.duplicate("X", div(number, 10)) \
                <> numeral(rem(number, 10))

              _ when number < 10 ->
                case div(number, 5) do
                  a when a >= 1 and number == 9 -> "IX"
                  a when a >= 1 and number >= 5 ->
                    "V" <> String.duplicate("I", rem(number, 5))
                  a when a < 1 and number == 4 -> "IV"
                  _ ->
                    String.duplicate("I", number)
                end
            end
        end
    end
  end
end
