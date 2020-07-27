class MatchData {
  final int teamNumber;
  final int matchNumber;
  final DateTime time;
  final String scout;
  final Map<String, dynamic> data;

  MatchData(
    this.teamNumber,
    this.matchNumber,
    this.time,
    this.scout,
    this.data
  );

  Map<String, dynamic> toJson() {
    return {
      'team': this.teamNumber,
      'match': this.matchNumber,
      'time': this.time,
      'scout': this.scout,
      'data': this.data
    };
  }
}