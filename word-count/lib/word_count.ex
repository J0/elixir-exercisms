defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  require Logger

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/[!#$%&()*+,.:;<=>?@\^`{|}~]/, "")
    |> String.downcase()
    |> String.split([" ", "_"], trim: true)
    |> Enum.reduce(%{}, &increment/2)
  end

  def increment(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end
