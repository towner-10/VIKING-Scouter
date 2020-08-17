import 'package:hive/hive.dart';

part 'teamData.g.dart';

@HiveType(typeId : 3)
class TeamData {

  @HiveField(0)
  final int teamNumber;

  @HiveField(1)
  String teamName;

  @HiveField(2)
  Map<String, dynamic> scoutData;

  @HiveField(3)
  String headerImage;

  @HiveField(4)
  List<String> images;

  TeamData({this.teamNumber, this.teamName, this.scoutData, this.headerImage, this.images});
}