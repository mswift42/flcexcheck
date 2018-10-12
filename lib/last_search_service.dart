import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:async';

class LastSearchService {
  final String lastSearchesFile = 'lastsearches.txt';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$lastSearchesFile');
  }

  Future<File> writeSearches(List<String> searches) async {
    final File = await _localFile;
    return File.writeAsString(searches.join(','));
  }

  Future<List<String>> readSearches() async {
    try {
      final File = await _localFile;

      String contents = await File.readAsString();
      return contents.split(',');
    } catch (e) {
      print(e);
    }
  }


}