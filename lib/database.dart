import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:viking_scouter/models/matchData.dart';

class Database {
  static Database _instance;

  Box _workingMatchData;
  Box _matchData;
  Box _teamData;
  Box _preferences;

  /// Initializes a new match within the database with the team number and match number in the temp box
  initNewMatch(int teamNumber, int matchNumber) {
    _workingMatchData.clear();
    _workingMatchData.put('teamNumber', teamNumber);
    _workingMatchData.put('matchNumber', matchNumber);
  }

  /// Add a new match
  newMatchData(MatchData data) {
    _matchData.add(data.toJson());
  }

  /// Remove a match from the database using its index
  removeMatchData(int index) {
    _matchData.deleteAt(index);
  }

  /// This will update a key in the workingMatchData Hive database with the given value.
  /// Returns a bool to represent the success of the operation.
  /// 
  /// ```dart
  /// updateWorkingMatchDataValue('key', true);
  /// ```
  bool updateWorkingMatchDataValue(String key, dynamic value) {
    if (_workingMatchData.isOpen == true) {
      _workingMatchData.put(key, value);
      return true;
    }

    return false;
  }

  bool isFirstLaunch() {
    bool firstLaunch = _preferences.get('firstLaunch', defaultValue: true);

    if (firstLaunch == null || firstLaunch == true) {
      return true;
    }

    return false;
  }

  bool updatePreference(String key, dynamic value) {
    if (_preferences.isOpen == true) {
      _preferences.put(key, value);
      return true;
    }

    return false;
  }

  dynamic getPreference(String key) {
    return _preferences.get(key);
  }

  dynamic getPreferenceDefault(String key, dynamic defaultValue) {
    return _preferences.get(key, defaultValue: defaultValue);
  }

  List<String> getCompetitions() {
    return _preferences.get('competitions', defaultValue: ['Miami Valley Regional', 'Greater Kansas City Regional']);
  }

  MatchData getValues() {
    int teamNumber;
    int matchNumber;
    Map<String, dynamic> data = new Map<String, dynamic>();

    _workingMatchData.keys.forEach((key) {
      switch(key.toString()) {
        case "teamNumber":
          teamNumber = _workingMatchData.get(key);
          break;
        case "matchNumber":
          matchNumber = _workingMatchData.get(key);
          break;
        default:
          data[key.toString()] = _workingMatchData.get(key);
          break;
      }
    });

    return new MatchData(teamNumber, matchNumber, DateTime.now(), getPreferenceDefault('scoutName', null), data);
  }

  static Database getInstance() {
    if (_instance == null) _instance = new Database();

    return _instance;
  }

  initializeHive() async {
    Directory dir = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(dir.path + "/database");

    _workingMatchData = await Hive.openBox('workingMatchData');
    _preferences = await Hive.openBox('preferences');
    _matchData = await Hive.openBox('matchData');
    _teamData = await Hive.openBox('teamData');
  }
}