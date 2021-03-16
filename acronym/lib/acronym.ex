defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r{[-._ ]+})
    |> Enum.reduce([], fn e, acc -> acc ++ split_by_title_case(e) end)
    |> Enum.map(&String.at(&1, 0))
    |> Enum.map(&String.upcase(&1))
    |> to_string()
  end

  defp split_by_title_case(string), do: String.split(string, ~r{(?<=[a-z])(?=[A-Z])})
end
