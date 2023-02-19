import 'package:flutter/material.dart';
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
  late int bottomNavIndex;
  @override
  void initState() {
    BLEProvider.instance.requestPermissions().then((value) {
      BLEProvider.instance.startScan();
    });
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    bottomNavIndex = 0;
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).backgroundColor,
        onTap: (int tappedIndex) {
          setState(() {
            bottomNavIndex = tappedIndex;
          });
        },
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFFFFFFFF),
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6B6B6B),
        ),
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/logos/SubtractHome.svg",
              color: const Color(0xFF9C77F5),
            ),
            icon: SvgPicture.asset(
              "assets/logos/White.svg",
              color: const Color(0xFF6B6B6B),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/logos/SubtractMapFilled.svg",
              color: const Color(0xFF9C77F5),
            ),
            icon: SvgPicture.asset(
              "assets/logos/Map.svg",
              color: const Color(0xFF6B6B6B),
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/logos/placesFilled.svg",
              color: const Color(0xFF9C77F5),
            ),
            icon: SvgPicture.asset(
              "assets/logos/places.svg",
              color: const Color(0xFF6B6B6B),
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/logos/settingsFilled.svg",
              color: const Color(0xFF9C77F5),
            ),
            icon: SvgPicture.asset(
              "assets/logos/settings.svg",
              color: const Color(0xFF6B6B6B),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
