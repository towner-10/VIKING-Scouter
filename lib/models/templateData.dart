import 'package:hive/hive.dart';

part 'templateData.g.dart';

final Template defaultTemplate = new Template(
  name: "2020: Infinite Recharge",
  data: [
    new TemplateData(title: "Autonomous", type: TemplateDataType.Header),
    new TemplateData(title: "Crossed Auto Line", dbName: "crossedAutoLine", type: TemplateDataType.BubbleTab),
    new TemplateData(title: "High Goal - Inner", dbName: "autoHighGoalInner", type: TemplateDataType.Counter),
    new TemplateData(title: "High Goal - Outer", dbName: "autoHighGoalOuter", type: TemplateDataType.Counter),
    new TemplateData(title: "Low Goal", dbName: "autoLowGoal", type: TemplateDataType.Counter),
    new TemplateData(title: "Tele-op", type: TemplateDataType.Header),
    new TemplateData(title: "High Goal - Inner", dbName: "highGoalInner", type: TemplateDataType.Counter),
    new TemplateData(title: "High Goal - Outer", dbName: "highGoalOuter", type: TemplateDataType.Counter),
    new TemplateData(title: "Low Goal", dbName: "lowGoal", type: TemplateDataType.Counter),
    new TemplateData(title: "Endgame", type: TemplateDataType.Header),
    new TemplateData(title: "Climb", dbName: "climb", type: TemplateDataType.BubbleTab),
    new TemplateData(title: "Balanced", dbName: "balanced", type: TemplateDataType.BubbleTab),
    new TemplateData(title: "Alliance Score", dbName: "score", type: TemplateDataType.NumberInput),
    new TemplateData(title: "Ranking Points", dbName: "rp", type: TemplateDataType.Counter),
    new TemplateData(title: "Match Notes", type: TemplateDataType.Header),
    new TemplateData(dbName: "matchNotes", type: TemplateDataType.TextInput)
  ]
);

@HiveType(typeId : 0)
class Template {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<TemplateData> data;

  Template({this.name, this.data});
}

@HiveType(typeId : 1)
enum TemplateDataType {

  @HiveField(0)
  BubbleTab,

  @HiveField(1)
  Counter,

  @HiveField(2)
  TextInput,

  @HiveField(3)
  NumberInput,

  @HiveField(4)
  Timer,

  @HiveField(5)
  Header
}

@HiveType(typeId : 2)
class TemplateData {

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String dbName;

  @HiveField(2)
  final TemplateDataType type;

  TemplateData({this.title, this.dbName, this.type});
}