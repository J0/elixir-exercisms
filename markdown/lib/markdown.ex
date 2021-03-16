defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    String.split(markdown, "\n")
    |> Enum.map(fn line -> process(line) end)
    |> Enum.join()
    |> wrap_list()
  end

  defp process(line) do
    cond do
      String.starts_with?(line, "#") -> parse_header_md_level(line)
      String.starts_with?(line, "*") -> parse_list_md_level(line)
      true -> String.split(line) |> join_words_with_tags() |> enclose("p")
    end
  end

  defp enclose(str, tag), do: "<#{tag}>#{str}</#{tag}>"

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    enclose(Enum.join(t, " "), "h#{String.length(h)}")
  end

  defp parse_list_md_level(list) do
    String.trim_leading(list, "* ")
    |> String.split()
    |> join_words_with_tags()
    |> enclose("li")
  end

  defp join_words_with_tags(words) do
    words |> Enum.map(&replace_md_with_tag(&1)) |> Enum.join(" ")
  end

  defp replace_md_with_tag(md) do
    md |> replace_prefix_md() |> replace_suffix_md()
  end

  defp replace_prefix_md(w) do
    cond do
      String.starts_with?(w, "__") -> String.replace(w, "__", "<strong>", global: false)
      String.starts_with?(w, "_") -> String.replace(w, "_", "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      String.ends_with?(w, "__") -> String.replace(w, "__", "</strong>")
      String.ends_with?(w, "_") -> String.replace(w, "_", "</em>")
      true -> w
    end
  end

  defp wrap_list(l) do
    String.replace(l, "<li>", "<ul><li>", global: false)
    |> String.replace_suffix(
      "</li>",
      "</li></ul>"
    )
  end
end
