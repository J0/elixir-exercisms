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
    divisible_by_three = rem(number, 3) == 0
    divisible_by_five = rem(number, 5) == 0
    divisible_by_seven = rem(number, 7) == 0

    cond do
      divisible_by_three and divisible_by_five and divisible_by_seven -> "PlingPlangPlong"
      divisible_by_three and divisible_by_five -> "PlingPlang"
      divisible_by_three and divisible_by_seven -> "PlingPlong"
      divisible_by_five and divisible_by_seven -> "PlangPlong"
      divisible_by_three -> "Pling"
      divisible_by_five -> "Plang"
      divisible_by_seven -> "Plong"
      true -> to_string(number)
    end
  end
end
