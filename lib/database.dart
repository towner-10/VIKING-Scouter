import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:viking_scouter/models/matchData.dart';
import 'package:viking_scouter/models/teamData.dart';
import 'package:viking_scouter/models/templateData.dart';

class Database {
  
  static Database _instance;

  Box _workingMatchData;
  Box _workingTemplateData;
  Box _matchData;
  Box _templateData;
  Box _teamData;
  Box _preferences;

  /// Initializes a new match within the database with the team number and match number in the temp box
  initNewMatch(int teamNumber, int matchNumber) async {
    _workingMatchData.clear().then((value) {
      _workingMatchData.put('teamNumber', teamNumber);
      _workingMatchData.put('matchNumber', matchNumber);
    });
  }

  initNewTemplate(String name) async {
    _workingTemplateData.clear().then((value) {
      _workingTemplateData.put('name', name);
    });
  }

  /// Add a new match
  newMatchData(MatchData data) {
    _matchData.add(data.toJson());
  }

  /// Remove a match from the database using its index
  removeMatchData(int index) {
    _matchData.deleteAt(index);
  }

  clearMatchData() {
    _matchData.clear();
  }

  /// Add a new template
  newTemplate(Template data) {
    _templateData.add(data);
  }

  /// Remove a template from the database using its index
  removeTemplate(int index) {
    _templateData.deleteAt(index);
  }

  removeCompetition(int index) {
    List<String> data = _preferences.get('competitions');

    data.removeAt(index);

    _preferences.put('competitions', data);
  }

  clearTemplateData() {
    _templateData.clear();
  }

  List<MatchData> getMatches() {
    List<MatchData> matches = new List<MatchData>();

    for (int i = 0; i < _matchData.length; i++) {
      matches.add(MatchData.fromJson(Map<String, dynamic>.from(_matchData.getAt(i))));
    }

    return matches;
  }

  List<Template> getTemplates() {
    List<Template> templates = new List<Template>();

    _templateData.toMap().forEach((key, value) {
      templates.add(value);
    });

    templates.add(defaultTemplate);

    return templates;
  }

  /// This will update a key in the workingMatchData Hive database with the given value.
  /// Returns a bool to represent the success of the operation.
  bool updateWorkingMatchDataValue(String key, dynamic value) {
    if (_workingMatchData.isOpen == true) {
      _workingMatchData.put(key, value);
      return true;
    }

    return false;
  }

  bool updateWorkingTemplateDataValue(String key, dynamic value) {
    if (_workingTemplateData.isOpen == true) {
      return true;
    }

    return false;
  }

  dynamic getWorkingTemplateDataValue(String key) {
    return _workingTemplateData.get(key);
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

  MatchData getWorkingMatchDataValues() {
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

    return new MatchData(
      team: teamNumber,
      match: matchNumber,
      time: DateTime.now(),
      scout: getPreferenceDefault('scoutName', '').toString(),
      data: data
    );
  }

  static Database getInstance() {
    if (_instance == null) _instance = new Database();

    return _instance;
  }

  initializeHive() async {
    Directory dir = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(dir.path + "/database");

    Hive.registerAdapter(TemplateAdapter());
    Hive.registerAdapter(TemplateDataAdapter());
    Hive.registerAdapter(TemplateDataTypeAdapter());
    Hive.registerAdapter(TeamDataAdapter());

    _workingMatchData = await Hive.openBox('workingMatchData');
    _workingTemplateData = await Hive.openBox('workingTemplateData');
    _preferences = await Hive.openBox('preferences');
    _matchData = await Hive.openBox('matchData');
    _templateData = await Hive.openBox<Template>('templateData');
    _teamData = await Hive.openBox<TeamData>('teamData');
  }
}