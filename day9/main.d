import std.stdio;
import std.string;
import std.array;
import std.typecons;
import std.conv;
import std.algorithm;

void main() {
  File file = File("inputs/input.txt", "r");
  // (x, y)
  Tuple!(int, int) head_position = Tuple!(int, int)(1000, 1000);
  Tuple!(int, int)[] tail_positions = [];
  Tuple!(int, int)[] last_tail_positions = [];
  int tail_length = 1; // 1 for 1., 9 for 2.

  for (int i = 0; i < tail_length; i++) {
    tail_positions ~= Tuple!(int, int)(1000, 1000);
  }

  while (!file.eof()) {
    string line = file.readln();
    auto words = line.split(" ");

    if (words.length != 2) {
      continue;
    }

    string direction = words[0].strip();
    string amount_as_string = words[1].strip();
    int amount = to!int(amount_as_string);

    for (int amount_indx = 0; amount_indx < amount; amount_indx++) {
      if (direction == "R") {
        head_position[0]++;
      } else if (direction == "L") {
        head_position[0]--;
      } else if (direction == "U") {
        head_position[1]++;
      } else if (direction == "D") {
        head_position[1]--;
      } else {
        writeln("invalid direction");
      }

      if (head_position[0] < 0 || head_position[1] < 0) {
        writeln("negative position");
        continue;
      }

      for (int j = 0; j < tail_positions.length; j++) {
        int y_diff, x_diff;

        if (j == 0) {
          x_diff = head_position[0] - tail_positions[j][0];
          y_diff = head_position[1] - tail_positions[j][1];
        } else {
          x_diff = tail_positions[j - 1][0] - tail_positions[j][0];
          y_diff = tail_positions[j - 1][1] - tail_positions[j][1];
        }

        if (x_diff >= -1 && x_diff <= 1 && y_diff >= -1 && y_diff <= 1) {
          // Don't do anything
          continue;
        } else if (x_diff == 0) {
          if (y_diff > 0) {
            tail_positions[j][1]++;
          } else {
            tail_positions[j][1]--;
          }
        } else if (y_diff == 0) {
          if (x_diff > 0) {
            tail_positions[j][0]++;
          } else {
            tail_positions[j][0]--;
          }
        } else {
          bool is_up = y_diff > 0;
          bool is_right = x_diff > 0;
          if (is_up && is_right) {
            tail_positions[j][0]++;
            tail_positions[j][1]++;
          } else if (is_up && !is_right) {
            tail_positions[j][0]--;
            tail_positions[j][1]++;
          } else if (!is_up && is_right) {
            tail_positions[j][0]++;
            tail_positions[j][1]--;
          } else if (!is_up && !is_right) {
            tail_positions[j][0]--;
            tail_positions[j][1]--;
          }
        }
      }

      if (!(last_tail_positions.canFind(tail_positions[tail_positions.length - 1]))) {
        last_tail_positions ~= tail_positions[tail_positions.length - 1];
        continue;
      }
    }
  }

  int answer = cast(int)last_tail_positions.length; // add the initial pos

  writeln("tail positions: ", answer);

  file.close();
}
