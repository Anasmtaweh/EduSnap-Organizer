import 'dart:io';

bool isFilePath(String path) {
  return path.startsWith("/storage") ||
         path.startsWith("/data") ||
         File(path).existsSync();
}
