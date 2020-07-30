class MatchData {
  
  final int team;
  final int match;
  final DateTime time;
  final String scout;
  final Map<String, dynamic> data;

  MatchData({
    this.team,
    this.match,
    this.time,
    this.scout,
    this.data
  });

  factory MatchData.fromJson(Map<String, dynamic> json){
    return MatchData(
      team: json['team'],
      match: json['match'],
      time: json['time'],
      scout: json['scout'],
      data: Map<String, dynamic>.from(json['data'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team': this.team,
      'match': this.match,
      'time': this.time,
      'scout': this.scout,
      'data': this.data
    };
  }
}