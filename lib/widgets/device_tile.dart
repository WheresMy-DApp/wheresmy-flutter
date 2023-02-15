import 'dart:math';

import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {
  late String title;
  late String? location;
  late DateTime lastSeen;
  late Image tileImage;
  late double? width;
  late double? height;

  DeviceTile({
    super.key,
    required this.title,
    this.location,
    required this.lastSeen,
    required this.tileImage,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      const Color(0xFF05C19B),
      const Color(0xFF664BAF),
      const Color(0xFFAF952C),
    ];
    var random = Random();
    var color = colors[random.nextInt(colors.length)];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF191919),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox(
                width: 131,
                child: tileImage,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                location ?? "No location",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Container(
              width: 96,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6.3),
              decoration: const BoxDecoration(
                color: Color(0xFF393939),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lastSeen.millisecondsSinceEpoch -
                                  DateTime.now().millisecondsSinceEpoch <
                              2 * 60 * 1000
                          ? const Color(0xFF37CDAF)
                          : const Color(0xFFF6613E),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    lastSeen.millisecondsSinceEpoch -
                                DateTime.now().millisecondsSinceEpoch <
                            2 * 60 * 1000
                        ? "Active Now"
                        : lastSeen.toIso8601String(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
