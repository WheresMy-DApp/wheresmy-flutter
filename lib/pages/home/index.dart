import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:wheresmy/providers/auth_provider.dart';
import 'package:wheresmy/providers/ble_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheresmy/widgets/custom.dart';
import 'package:wheresmy/widgets/device_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AuthProvider _authProvider;
  late BuildContext mainContext;
  late BLEProvider _bleProvider;
  late TabController _tabController;
  @override
  void initState() {
    BLEProvider.instance.requestPermissions().then((value) {
      BLEProvider.instance.startScan();
    });
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
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              DeviceTile(
                title: "Rahul's iPhone",
                lastSeen: DateTime.now(),
                tileImage: Image.asset("assets/logos/iphone.png"),
                width: 221,
                height: 221,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
