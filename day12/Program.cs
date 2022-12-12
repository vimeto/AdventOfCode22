using System;
using System.IO;
using System.Collections.Generic;

namespace ReadFile {
  class Program {
    static bool first_assignment = true;

    static bool Dijkstra(ref PriorityQueue<List<(int, int)>, int> paths, ref List<(int, int)> visited, ref List<char[]> chars) {
      List<(int, int)> this_path = paths.Dequeue();
      (int, int) current_pos = this_path[this_path.Count - 1];

      if (visited.Contains(current_pos)) {
        if (paths.Count == 0) {
          Console.WriteLine("No path found");
          paths.Enqueue(this_path, this_path.Count);
          return true;
        }
        return false;
      }

      visited.Add(current_pos);

      var this_char = chars[current_pos.Item1][current_pos.Item2];
      if (first_assignment && this_char == 'S') { this_char = 'a'; }
      if (!first_assignment && this_char == 'E') { this_char = 'z'; }

      // Check if we are at the end
      if ((first_assignment && this_char == 'E') || (!first_assignment && (this_char == 'a' || this_char == 'S'))) {
        paths.Enqueue(this_path, this_path.Count);
        Console.WriteLine("Found path");
        return true;
      }

      // go left
      if (current_pos.Item2 - 1 >= 0 && current_pos.Item2 - 1 < chars[current_pos.Item1].Length) {
        var another_char = chars[current_pos.Item1][current_pos.Item2 - 1];

        if (first_assignment && another_char == 'E') { another_char = 'z'; }
        if (!first_assignment && another_char == 'S') { another_char = 'a'; }

        int diff = this_char - another_char;
        if ((first_assignment && diff >= -1) || (!first_assignment && diff <= 1)) {
          if (!visited.Contains((current_pos.Item1, current_pos.Item2 - 1))) {
            List<(int, int)> new_path = new List<(int, int)>(this_path);
            new_path.Add((current_pos.Item1, current_pos.Item2 - 1));
            paths.Enqueue(new_path, new_path.Count);
          }
        }
      }
      // go right
      if (current_pos.Item2 + 1 >= 0 && current_pos.Item2 + 1 < chars[current_pos.Item1].Length) {
        var another_char = chars[current_pos.Item1][current_pos.Item2 + 1];

        if (first_assignment && another_char == 'E') { another_char = 'z'; }
        if (!first_assignment && another_char == 'S') { another_char = 'a'; }

        int diff = this_char - another_char;
        if ((first_assignment && diff >= -1) || (!first_assignment && diff <= 1)) {
          if (!visited.Contains((current_pos.Item1, current_pos.Item2 + 1))) {
            // Console.WriteLine("Going right");
            List<(int, int)> new_path = new List<(int, int)>(this_path);
            new_path.Add((current_pos.Item1, current_pos.Item2 + 1));
            paths.Enqueue(new_path, new_path.Count);
          }
        }
      }
      // go up
      if (current_pos.Item1 - 1 >= 0 && current_pos.Item1 - 1 < chars.Count) {
        var another_char = chars[current_pos.Item1 - 1][current_pos.Item2];

        if (first_assignment && another_char == 'E') { another_char = 'z'; }
        if (!first_assignment && another_char == 'S') { another_char = 'a'; }

        int diff = this_char - another_char;
        if ((first_assignment && diff >= -1) || (!first_assignment && diff <= 1)) {
          if (!visited.Contains((current_pos.Item1 - 1, current_pos.Item2))) {
            // Console.WriteLine("Going up");
            List<(int, int)> new_path = new List<(int, int)>(this_path);
            new_path.Add((current_pos.Item1 - 1, current_pos.Item2));
            paths.Enqueue(new_path, new_path.Count);
          }
        }
      }
      // go down
      if (current_pos.Item1 + 1 >= 0 && current_pos.Item1 + 1 < chars.Count) {
        var another_char = chars[current_pos.Item1 + 1][current_pos.Item2];

        if (first_assignment && another_char == 'E') { another_char = 'z'; }
        if (!first_assignment && another_char == 'S') { another_char = 'a'; }

        int diff = this_char - another_char;
        if ((first_assignment && diff >= -1) || (!first_assignment && diff <= 1)) {
          if (!visited.Contains((current_pos.Item1 + 1, current_pos.Item2))) {
            // Console.WriteLine("Going down");
            List<(int, int)> new_path = new List<(int, int)>(this_path);
            new_path.Add((current_pos.Item1 + 1, current_pos.Item2));
            paths.Enqueue(new_path, new_path.Count);
          }
        }
      }

      if (paths.Count == 0) {
        Console.WriteLine("No path found");
        paths.Enqueue(this_path, this_path.Count);
        return true;
      }

      return false;
    }



    static void Main(string[] args) {
      var lines_arr = File.ReadAllLines("inputs/input.txt");
      var lines = new List<string>(lines_arr);
      var chars = new List<char[]>();
      (int, int) my_pos = (0, 0);

      for (int i = 0; i < lines.Count; i++) {
        chars.Add(lines[i].ToCharArray());
      }

      // TODO: prob can do without looping
      for (int i = 0; i < chars.Count; i++) {
        for (int j = 0; j < chars[i].Length; j++) {
          if ((first_assignment && chars[i][j] == 'S') || (!first_assignment && chars[i][j] == 'E')) {
            my_pos = (i, j);
          }
          // Console.Write(chars[i][j] + " ");
        }
        // Console.WriteLine();
      }

      PriorityQueue<List<(int, int)>, int> head = new PriorityQueue<List<(int, int)>, int>();
      List<(int, int)> visited = new List<(int, int)>();

      head.Enqueue(new List<(int, int)> () { (my_pos.Item1, my_pos.Item2) }, 1);

      bool result = Dijkstra(ref head, ref visited, ref chars);

      while (result == false) {
        result = Dijkstra(ref head, ref visited, ref chars);
      }

      var p = head.Peek();

      Console.WriteLine(p.Count - 1);

      // for (int i = 0; i < chars.Count; i++) {
      //   for (int j = 0; j < chars[i].Length; j++) {
      //     char this_char = chars[i][j];
      //     if (p.Contains((i, j))) {
      //       var index = p.IndexOf((i, j));
      //       if (index == 0) {
      //         this_char = 'E';
      //       } else if (index == p.Count - 1) {
      //         this_char = 'S';
      //       } else {
      //         var next_char_pos = p[index + 1];
      //         var x_diff = next_char_pos.Item1 - i;
      //         var y_diff = next_char_pos.Item2 - j;
      //         if (x_diff == 1) {
      //           this_char = 'v';
      //         } else if (x_diff == -1) {
      //           this_char = '^';
      //         } else if (y_diff == 1) {
      //           this_char = '>';
      //         } else if (y_diff == -1) {
      //           this_char = '<';
      //         }
      //       }
      //     }
      //     Console.Write(this_char + " ");
      //   }
      //   Console.WriteLine();
      // }

      // for (int i = 0; i < p.Count; i++) {
      //   var difference_to_previous = 0;
      //   if (i > 0) {
      //     var previous = p[i - 1];
      //     var current = p[i];
      //     difference_to_previous = chars[previous.Item1][previous.Item2] - chars[current.Item1][current.Item2];
      //   }
      //   Console.WriteLine(p[i] + " " + chars[p[i].Item1][p[i].Item2] + " " + difference_to_previous);
      // }
    }
  }
}
