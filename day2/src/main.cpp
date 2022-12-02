#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <algorithm>
#include <map>

#include "PathLoader.hpp"

int calculatePoints(char a, char b) {
  int winPoints = 0, choisePints = 0;

  std::map<int, char> charMap = {
    {0, 'A'},
    {1, 'B'},
    {2, 'C'}
  };

  auto it = std::find_if(
    charMap.begin(),
    charMap.end(),
    [&](std::pair<int, char> pair) { return pair.second == a; }
  );

  int yourPoints = (it == charMap.end()) ? -1 : it->first;
  int neededPoints;

  // there are no -1


  if (b == 'X') {
    neededPoints = (yourPoints - 1) % 3;
    if (neededPoints < 0) { neededPoints += 3; }
  } else if (b == 'Y') {
    neededPoints = yourPoints;
  } else {
    neededPoints = (yourPoints + 1) % 3;
  }

  if (neededPoints == yourPoints) {
    winPoints = 3;
  } else if (neededPoints == (yourPoints + 1) % 3) {
    winPoints = 6;
  }

  if (neededPoints == 0) {
    choisePints = 1;
  } else if (neededPoints == 1) {
    choisePints = 2;
  } else if (neededPoints == 2) {
    choisePints = 3;
  }

  return winPoints + choisePints;
}

int main() {
  PathLoader path_loader;
  std::string filepath = path_loader.LoadInputPath("input.txt");
  std::string line;
  int score = 0;
  int index = 0;

  std::ifstream file(filepath);
  if (file.is_open()) {
    while (std::getline(file, line)) {
      std::stringstream ss(line);
      std::string a, b;
      ss >> a >> b;

      int s = calculatePoints(a[0], b[0]);
      score += s;
    }
    file.close();
  } else {
    std::cout << "Error" << std::endl;
  }

  std::cout << score << std::endl;
  return 0;
}
