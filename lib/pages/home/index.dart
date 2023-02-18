import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:wheresmy/providers/auth_provider.dart';
import 'package:wheresmy/providers/ble_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheresmy/services/navigation_service.dart';
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
          indicatorColor: Color(0xFF9C77F5),
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
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: double.infinity,
          height: 310,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: [
              DeviceTile(
                title: "Rahul's iPhone",
                lastSeen: DateTime.now(),
                tileImage: Image.asset("assets/logos/iphone.png"),
                width: 180,
                height: 180,
              ),
              DeviceTile(
                title: "Rahul's iPhone",
                lastSeen: DateTime.now(),
                tileImage: Image.asset("assets/logos/iphone.png"),
                width: 180,
                height: 180,
              ),
              DeviceTile(
                title: "Rahul's iPhone",
                lastSeen: DateTime.now(),
                tileImage: Image.asset("assets/logos/iphone.png"),
                width: 180,
                height: 180,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                  colors: [Color(0xFF9C77F5), Color(0xFF7751F1)])),
          child: const Icon(
            Icons.add,
            color: Color(0xFFFFFFFF),
          ),
        ),
        onPressed: () {
          NavigationService.instance.navigateTo("add_device");
        },
      ),
    );
  }
}
