defmodule AdventOfCode do

  def read_file do
    {:ok, line_stream} = File.read("inputs/input.txt")
    substr_len = 14

    list_of_characters = String.graphemes(line_stream)

    (1..(length(list_of_characters) - 1)) |> Enum.find(fn i ->
      if i < substr_len do
        false
      else
        substring = Enum.slice(list_of_characters, i - substr_len, substr_len)
        number_or_unique_characters = length(Enum.uniq(substring))
        if number_or_unique_characters == substr_len do
          IO.puts("Found a match: #{Enum.join(substring, "")}, at index #{i}")
          true
        else
          false
        end
      end
    end)
  end
end

AdventOfCode.read_file
