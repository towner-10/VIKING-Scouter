import 'package:flutter/material.dart';
import 'package:viking_scouter/models/matchData.dart';

class LatestMatchDataCard extends StatelessWidget {

  final MatchData data;

  String score;
  String rp;

  LatestMatchDataCard({@required this.data}) {
    score = data.data['score'] != null ? (data.data['score']).toString() : '0';
    rp = data.data['rp'] != null ? (data.data['rp']).toString() : '0';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21.0),
        color: const Color(0xff141333),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(5, 5),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'FRC ' + data.team.toString(),
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 20,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  score + ' Match Score',
                  style: TextStyle(
                    fontFamily: 'TT Norms',
                    fontSize: 15,
                    color: const Color(0xffffffff),
                  ),
                ),
                Text(
                  rp + ' Ranking Points',
                  style: TextStyle(
                    fontFamily: 'TT Norms',
                    fontSize: 15,
                    color: const Color(0xffffffff),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Match ' + data.match.toString(),
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
            )
          )
        ],
      ),
    );
  }
}