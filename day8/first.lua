function Forward_row_pass(lines_chars, visibles, row_index)
  smallest = tonumber(lines_chars[row_index][1])
  length = #lines_chars[row_index]
  for i = 1, length do
    char = lines_chars[row_index][i]
    if i == 1 or i == length then
      visibles[row_index][i] = true
    else
      char_as_int = tonumber(char)

      if char_as_int > smallest then
        smallest = char_as_int
        visibles[row_index][i] = true
      end
    end
  end
end

function Backwards_row_pass(lines_chars, visibles, row_index)
  smallest = tonumber(lines_chars[row_index][#lines_chars[row_index]])
  length = #lines_chars[row_index]

  for i = length, 1, -1 do
    if i == 1 or i == length then
      visibles[row_index][i] = true
    else
      char = lines_chars[row_index][i]
      char_as_int = tonumber(char)

      if char_as_int > smallest then
        smallest = char_as_int
        visibles[row_index][i] = true
      end
    end
  end
end

function Forward_column_pass(lines_chars, visibles, column_index)
  smallest = tonumber(lines_chars[1][column_index])
  length = #lines_chars
  for i = 1, length do
    char = lines_chars[i][column_index]
    if i == 1 or i == length then
      visibles[i][column_index] = true
    else
      char_as_int = tonumber(char)

      if char_as_int > smallest then
        smallest = char_as_int
        visibles[i][column_index] = true
      end
    end
  end
end

function Backwards_column_pass(lines_chars, visibles, column_index)
  smallest = tonumber(lines_chars[#lines_chars][column_index])
  length = #lines_chars

  for i = length, 1, -1 do
    if i == 1 or i == length then
      visibles[i][column_index] = true
    else
      char = lines_chars[i][column_index]
      char_as_int = tonumber(char)

      if char_as_int > smallest then
        smallest = char_as_int
        visibles[i][column_index] = true
      end
    end
  end
end

file = io.open("inputs/input.txt", "r")
lines_chars = {}
row_visibles = {}
column_visibles = {}
for line in file:lines() do
  if line ~= "" then
    line_chars = {}
    row_visibles_for_line = {}
    column_visibles_for_line = {}
    for i = 1, #line do
      line_chars[i] = line:sub(i, i)
      row_visibles_for_line[i] = false
      column_visibles_for_line[i] = false
    end
    lines_chars[#lines_chars + 1] = line_chars
    row_visibles[#row_visibles + 1] = row_visibles_for_line
    column_visibles[#column_visibles + 1] = column_visibles_for_line
  end
end

for i = 1, #lines_chars[1] do
  Forward_row_pass(lines_chars, row_visibles, i)
  Backwards_row_pass(lines_chars, row_visibles, i)
  Forward_column_pass(lines_chars, column_visibles, i)
  Backwards_column_pass(lines_chars, column_visibles, i)
end

total_count = 0

for i = 1, #lines_chars do
  for j = 1, #lines_chars[i] do
    if row_visibles[i][j] == false and column_visibles[i][j] == false then
      -- io.write(lines_chars[i][j])
    else
      total_count = total_count + 1
    end
  end

  -- print()
end

print(total_count)
