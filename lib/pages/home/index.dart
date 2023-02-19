import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheresmy/pages/home/maps.dart';
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
        bottom: bottomNavIndex == 0
            ? TabBar(
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
              )
            : null,
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider.instance),
          ChangeNotifierProvider.value(value: BLEProvider.instance)
        ],
        child: _mainUI(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.transparent,
      //   child: Container(
      //     height: 60,
      //     width: 60,
      //     decoration: const BoxDecoration(
      //         shape: BoxShape.rectangle,
      //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //         gradient: LinearGradient(
      //             colors: [Color(0xFF9C77F5), Color(0xFF7751F1)])),
      //     child: const Icon(
      //       Icons.add,
      //       color: Color(0xFFFFFFFF),
      //     ),
      //   ),
      //   onPressed: () {
      //     NavigationService.instance.navigateTo("add_device");
      //   },
      // ),
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
            label: "Maps",
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
            label: "Places",
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
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _mainUI() {
    return Builder(builder: (BuildContext innerContext) {
      _authProvider = Provider.of<AuthProvider>(innerContext);
      _bleProvider = Provider.of<BLEProvider>(innerContext);
      switch (bottomNavIndex) {
        case 1:
          return const MapsPage();
        case 3:
          return Container(
            child: Column(
              children: [
                Container(
                  height: 68,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF191919),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/logos/metamask_large.png",
                        width: 21,
                        height: 21,
                      ),
                      SizedBox(
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Metamask Wallet ID",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Text(
                              _authProvider.currentUser!.walletAddress,
                              style: const TextStyle(
                                color: Color(0xFF9C9C9C),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await _authProvider.logout();
                    NavigationService.instance.navigateTo("sign_in");
                  },
                  child: Container(
                    height: 68,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF191919),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/logos/Logoutlogout.svg",
                          color: const Color(0xFFF6613E),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Logout",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: const Color(0xFFF6613E)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        case 0:
        default:
          return Container(
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
          );
      }
    });
  }
}
