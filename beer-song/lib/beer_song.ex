defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    case number do
      x when x > 2 ->
        "#{x} bottles of beer on the wall, " <> \
        "#{x} bottles of beer.\n" <> \
        "Take one down and pass it around, " <> \
        "#{x-1} bottles of beer on the wall.\n"
      x when x == 2 ->
        "#{x} bottles of beer on the wall, " <> \
        "#{x} bottles of beer.\n" <> \
        "Take one down and pass it around, " <> \
        "#{x-1} bottle of beer on the wall.\n"
      x when x == 1 ->
        "#{x} bottle of beer on the wall, " <> \
        "#{x} bottle of beer.\n" <> \
        "Take it down and pass it around, " <> \
        "no more bottles of beer on the wall.\n" 
      x when x == 0 ->
        "No more bottles of beer on the wall, " <> \
        "no more bottles of beer.\n" <> \
        "Go to the store and buy some more, " <> \
        "99 bottles of beer on the wall.\n"
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range\\99..0) do
    Enum.to_list(range) \
    |> Enum.map(fn n -> verse(n) end)
    |> Enum.join("\n")
  end
end
