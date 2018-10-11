import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:async';

class LastSearchService {
  List<String> Searches = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/lastsearches.txt');
  }
}