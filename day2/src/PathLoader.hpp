#pragma once

#include <string>

class PathLoader {
public:
  PathLoader() {}

  std::string LoadInputPath(std::string filename) {
    std::string folder = "/inputs/";
    std::string file_path = __FILE__;
    std::string dir_path = file_path.substr(0, file_path.rfind("/"));
    std::string path = dir_path.substr(0, dir_path.rfind("/"));
    return path + folder + filename;
  }
};
