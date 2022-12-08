function Calculate_scenic_score(lines_chars, row_index, column_index)
  cell = lines_chars[row_index][column_index]
  cell_as_int = tonumber(cell)
  left_count = 0
  right_count = 0
  up_count = 0
  down_count = 0

  -- look left
  if column_index > 1 then
    for i = column_index - 1, 1, -1 do
      left_count = left_count + 1
      if tonumber(lines_chars[row_index][i]) >= cell_as_int then break end
    end
  end

  -- look right
  if column_index < #lines_chars[row_index] then
    for i = column_index + 1, #lines_chars[row_index] do
      right_count = right_count + 1
      if tonumber(lines_chars[row_index][i]) >= cell_as_int then break end
    end
  end

  -- look up
  if row_index > 1 then
    for i = row_index - 1, 1, -1 do
      up_count = up_count + 1
      if tonumber(lines_chars[i][column_index]) >= cell_as_int then break end
    end
  end

  -- look down
  if row_index < #lines_chars then
    for i = row_index + 1, #lines_chars do
      down_count = down_count + 1
      if tonumber(lines_chars[i][column_index]) >= cell_as_int then break end
    end
  end

  return left_count * right_count * up_count * down_count
end

file = io.open("inputs/input.txt", "r")
lines_chars = {}
for line in file:lines() do
  if line ~= "" then
    line_chars = {}
    for i = 1, #line do
      line_chars[i] = line:sub(i, i)
    end
    lines_chars[#lines_chars + 1] = line_chars
  end
end

max_scenic_score = 0
max_position = {0, 0}

for i = 1, #lines_chars do
  for j = 1, #lines_chars[i] do
    scenic_score = Calculate_scenic_score(lines_chars, i, j)
    if scenic_score > max_scenic_score then
      max_scenic_score = scenic_score
      max_position = {i, j}
    end
  end
end

print(max_scenic_score, max_position[1], max_position[2])
