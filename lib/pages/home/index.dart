import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheresmy/widgets/custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: customAppBar(
        context: context,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            customTab(
              leading: SvgPicture.asset(
                "assets/logos/all.svg",
              ),
              title: "All Devices",
            ),
            customTab(
              leading: SvgPicture.asset(
                "assets/logos/mobile.svg",
              ),
              title: "Mobiles",
            ),
            customTab(
              leading: SvgPicture.asset(
                "assets/logos/pc.svg",
              ),
              title: "PCs",
            ),
          ],
        ),
      ),
    );
  }
}
