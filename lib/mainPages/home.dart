import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/newMatch.dart';
import 'package:viking_scouter/mainPages/settings.dart';
import 'package:viking_scouter/mainPages/teams.dart';
import 'package:viking_scouter/models/matchData.dart';
import 'package:viking_scouter/widgets/conditionalBuilder.dart';
import 'package:viking_scouter/widgets/latestMatchDataCard.dart';
import 'package:viking_scouter/widgets/subHeader.dart';

class Home extends StatefulWidget {
  
  final int initialPage;

  Home({this.initialPage = 0});

  @override
  HomeState createState() => HomeState(this.initialPage);
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {

  final Database _db = Database.getInstance();

  PageController controller;

  int _bottomNavIndex = 0;
  String title;

  bool switchValue = false;

  List<MatchData> matchData = new List<MatchData>();

  HomeState(int initialPage) {
    _bottomNavIndex = initialPage;
    this.controller = new PageController(initialPage: initialPage);
  }

  @override
  void initState() {
    super.initState();

    String scoutName = _db.getPreferenceDefault('scoutName', null);
    title = scoutName == null ? 'Today\'s\nMatches' : 'Welcome back,\n' + scoutName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontFamily: 'TT Norms',
                                    fontSize: 30,
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    backgroundColor: CustomColors.darkBlue,
                                    radius: 24,
                                    child: IconButton(
                                      icon: Icon(Icons.add),
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NewMatchPage())).then((value) => setState(() {}));
                                      }
                                    )
                                  )
                                )
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          ConditionalBuilder(
                            builder: Center(child: SubHeader("No Matches")),
                            condition: _db.getMatches().length == 0,
                          ),
                          ConditionalBuilder(
                            builder: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 15),
                                  child: SubHeader('Recent Top Matches'),
                                ),
                                Wrap(
                                  spacing: 15,
                                  runSpacing: 10,
                                  children: _db.getMatches().map((e) {
                                    return LatestMatchDataCard(data: e);
                                  }).toList().cast<Widget>(),
                                ),
                              ]
                            ),
                            condition: _db.getMatches().length != 0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20)
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
            Teams(),
            Settings()
          ],
        ),
      ), 
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          CustomBottomNavigationBarItem(
            icon: Icons.home,
            title: "Home",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.flag,
            title: "Teams",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.settings,
            title: "Settings",
          ),
        ],
        onTap: (position) {
          setState(() {
            _bottomNavIndex = position;
            controller.jumpToPage(_bottomNavIndex);
          });
        },
        backgroundColor: CustomColors.darkBlue,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        itemBackgroudnColor: CustomColors.darkBlue,
        itemOutlineColor: Colors.white,
      ),
    );
  }
}