import 'package:hive/hive.dart';

part 'teamData.g.dart';

@HiveType(typeId : 3)
class TeamData {

  @HiveField(0)
  final int teamNumber;

  @HiveField(1)
  final Map<String, dynamic> scoutData;

  @HiveField(2)
  final List<String> images;

  TeamData({this.teamNumber, this.scoutData, this.images});
}