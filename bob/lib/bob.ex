defmodule Bob do
  @spec hey(binary) :: <<_::40, _::_*8>>
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      forceful_question?(input) ->
        "Calm down, I know what I'm doing!"

      shouting?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  def question?(question) do
    String.trim(question)
    |> String.ends_with?("?")
  end

  def shouting?(question) do
    (question_with_no_number?(question) &&
       does_not_end_with_question_mark?(question)) ||
      exclamation?(question)
  end

  def question_with_no_number?(question) do
    String.upcase(question) == question && !String.match?(question, ~r/[0-9]/)
  end

  defp does_not_end_with_question_mark?(question) do
    !String.ends_with?(question, "?")
  end

  defp exclamation?(question) do
    String.contains?(question, "!") && question == String.upcase(question)
  end

  defp forceful_question?(question) do
    String.contains?(question, "?") && String.upcase(question) != String.downcase(question)
  end
end
