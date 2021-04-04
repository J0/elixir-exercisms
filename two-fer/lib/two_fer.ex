defmodule TwoFer do
  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  def two_fer(name) when is_number(name) do
    raise(FunctionClauseError)
  end

  def two_fer(name) when is_atom(name) do
    raise(FunctionClauseError)
  end

  def two_fer(name) when Kernel.is_bitstring(name) do
    "One for #{name}, one for me"
  end

  @spec two_fer :: <<_::184>>
  def two_fer(), do: "One for you, one for me"
end
