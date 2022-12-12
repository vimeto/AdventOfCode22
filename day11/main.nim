import std/sequtils
import std/re
# import std/parseutils
# from std/strutils import Digits, parseInt
import std/strutils
import std/algorithm


type
  Monkey* = object
    name*: int
    operator*: string
    operation_amount*: int
    items*: seq[int]
    divisible_by*: int
    if_true*: int
    if_false*: int
    score*: int

var monkeys: seq[Monkey]


proc readFileContents() =
  let f = open("inputs/input.txt")
  var monkey_active = false
  var monkey = Monkey()

  for line in f.lines:
    if line.len == 0:
      monkey_active = false
      monkeys.add(monkey)
      continue
    var monkey_title_matches: array[1, string]
    if match(line, re"Monkey (\d+):", monkey_title_matches):
      monkey_active = true
      monkey.name = parseInt(monkey_title_matches[0])
      continue
    if monkey_active:
      var monkey_operation_matches: array[2, string]
      if match(line, re".*new = old ([+|*]) (\d+)", monkey_operation_matches) and monkey_operation_matches.len == 2:
        monkey.operator = monkey_operation_matches[0]
        var operator_amount = monkey_operation_matches[1]
        monkey.operation_amount = parseInt(operator_amount)
        continue
      if match(line, re".*new = old (\*) (old)", monkey_operation_matches) and monkey_operation_matches.len == 2:
        monkey.operator = "^"
        monkey.operation_amount = 2
        continue
      var monkey_items_matches: array[1, string]
      if match(line, re".*items: (.+)", monkey_items_matches):
        monkey.items = monkey_items_matches[0].split(", ").map(parseInt)
        continue
      var monkey_divisible_by_matches: array[1, string]
      if match(line, re".*divisible by (\d+)", monkey_divisible_by_matches):
        monkey.divisible_by = parseInt(monkey_divisible_by_matches[0])
        continue
      var monkey_if_true_matches: array[1, string]
      if match(line, re".*If true: throw to monkey (\d+)", monkey_if_true_matches):
        monkey.if_true = parseInt(monkey_if_true_matches[0])
        continue
      var monkey_if_false_matches: array[1, string]
      if match(line, re".*If false: throw to monkey (\d+)", monkey_if_false_matches):
        monkey.if_false = parseInt(monkey_if_false_matches[0])
        continue

  monkeys.add(monkey)

proc getDivisor(): int =
  var d = 1
  for monke in monkeys:
    d *= monke.divisible_by

  return d

proc main() =
  readFileContents()

  var smallest_divisor = getDivisor()

  var count_index = 0
  var max_count = 10000
  var i = -1

  while count_index < max_count:
    # echo "count index: ", count_index + 1
    i = -1
    for monke in monkeys:
      i += 1
      # echo count_index, " . ", i
      if monkeys[i].items.len == 0:
        continue

      while monkeys[i].items.len > 0:
        var item = monkeys[i].items[0]
        monkeys[i].score += 1
        monkeys[i].items.delete(0)

        if monke.operator == "+":
          item += monke.operation_amount
        elif monke.operator == "*":
          item *= monke.operation_amount
        elif monke.operator == "^":
          item *= item

        item = item mod smallest_divisor
        # item = floor(item / 3).int # TODO: first part

        if item mod monkeys[i].divisible_by == 0:
          monkeys[monkeys[i].if_true].items.add(item)
        else:
          monkeys[monkeys[i].if_false].items.add(item)

    count_index += 1

proc cmpMonkeys(a, b: Monkey): int =
  if a.score > b.score:
    return -1
  elif a.score < b.score:
    return 1
  else:
    return 0

main()


monkeys.sort(cmpMonkeys)

for m in monkeys:
  echo m.name, " ", m.score
echo "-------------------"

echo "Top 2 scores are: ", monkeys[0].score * monkeys[1].score
