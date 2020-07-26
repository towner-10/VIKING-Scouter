import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

class BubbleTab extends StatefulWidget {

  final Function(bool) onChange;

  BubbleTab({this.onChange});

  @override
  BubbleTabState createState() => BubbleTabState(onChange);
}

class BubbleTabState extends State<BubbleTab> with SingleTickerProviderStateMixin {
  final Function(bool) onChange;
  TabController _tabController;

  BubbleTabState(this.onChange);

  @override
  void initState() {
    super.initState();
    _onChange(1);
    _tabController = new TabController(vsync: this, length: tabs.length, initialIndex: 1);
  }

  _onChange(int value) {
    switch(value) {
      case 0:
        onChange(true);
        return;
      case 1:
        onChange(false);
        return;
    }
  }

  final List<Tab> tabs = <Tab>[
    new Tab(text: "True"),
    new Tab(text: "False")
  ];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: new BubbleTabIndicator(
        indicatorHeight: 35.0,
        indicatorColor: const Color(0xff141333),
        tabBarIndicatorSize: TabBarIndicatorSize.tab,
      ),
      controller: _tabController,
      onTap: (value) => _onChange(value),
      unselectedLabelColor: const Color(0xff000000),
      labelColor: Colors.white,
      labelStyle: TextStyle(
        fontFamily: 'TT Norms',
        fontSize: 16
      ),
      tabs: tabs
    );
  }
}