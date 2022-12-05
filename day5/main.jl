open("inputs/input.txt") do io
  headerfound = false
  map_of_blocks = Dict()

  # ÷ is the integer division operator

  for line in eachline(io)
    line_length = length(line)

    if line_length < 2 || line[1:2] == " 1"
      headerfound = true
      continue
    end

    if !headerfound
      for block_start_index in 1:line_length ÷ 3
        start_index = (block_start_index - 1) * 3 + block_start_index
        end_index = start_index + 2
        if end_index > line_length
          break
        end
        block = line[start_index:end_index]
        if block[1] == '[' && block[end] == ']'
          parsed_block = block[2:end-1]
          if !haskey(map_of_blocks, block_start_index)
            map_of_blocks[block_start_index] = [parsed_block]
          else
            push!(map_of_blocks[block_start_index], parsed_block)
          end
        end
      end
    else
      regex = r"move (:?\d+) from (:?\d) to (:?\d)"
      regex_match = match(regex, line)
      if regex_match !== nothing
        captures = regex_match.captures
        parsed_first_capture = parse(Int, captures[1])
        parsed_second_capture = parse(Int, captures[2])
        parsed_third_capture = parse(Int, captures[3])

        elements = map_of_blocks[parsed_second_capture][1:parsed_first_capture]

        for element in reverse(elements)
          popfirst!(map_of_blocks[parsed_second_capture])
          pushfirst!(map_of_blocks[parsed_third_capture], element)
        end

        # for move_amount in 1:parsed_first_capture
        #   letter = map_of_blocks[parsed_second_capture][1]
        #   first_letter = popfirst!(map_of_blocks[parsed_second_capture])
        #   pushfirst!(map_of_blocks[parsed_third_capture], first_letter)
        # end # first assignment answer
      end
    end
  end

  for (key, value) in sort(collect(pairs(map_of_blocks)), by=x->x.first)
    print(value[1])
  end

  println("\nThanks")
end
