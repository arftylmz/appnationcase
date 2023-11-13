import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class SettingBarSheet extends StatefulWidget {
  final ScrollController scrollController;
  const SettingBarSheet({super.key, required this.scrollController});

  @override
  State<SettingBarSheet> createState() => _SettingBarSheetState();
}

class _SettingBarSheetState extends State<SettingBarSheet> {
  String iosVersion = "16.2";
  String androidVersion = "13";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    getDeviceVersions();
  });
  }

  Future<void> getDeviceVersions() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          androidVersion = androidInfo.version.release;
        });
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          iosVersion = iosInfo.systemVersion;
        });
      }
    } catch (e) {
      print('Error getting device version: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFFE5E5EA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            _settingWidget("assets/images/Info.png", "Help"),
            const Divider(
              thickness: 2,
            ),
            _settingWidget("assets/images/Star.png", "Rate Us"),
            const Divider(
              thickness: 2,
            ),
            _settingWidget(
                "assets/images/Export.png", "Share with Friends"),
            const Divider(
              thickness: 2,
            ),
            _settingWidget("assets/images/Scroll.png", "Terms of Use"),
            const Divider(
              thickness: 2,
            ),
            _settingWidget(
                "assets/images/ShieldCheck.png", "Privacy Policy"),
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/GitBranch.png",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "OS Version",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Galano Grotesque',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 0.16,
                  ),
                ),
                const Spacer(),
                Text(
                  Theme.of(context).platform == TargetPlatform.android
                      ? androidVersion
                      :  iosVersion,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0x993C3C43),
                    fontSize: 13,
                    fontFamily: 'Galano Grotesque',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 0.13,
                  ),
                ),
              ],
            )
              ],
            ),
            // Your other content here
          ],
        ),
      ),
    );
  }

  Row _settingWidget(String image, String name) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 50,
          width: 50,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Galano Grotesque',
            fontWeight: FontWeight.w500,
            height: 0,
            letterSpacing: 0.16,
          ),
        ),
        const Spacer(),
        Image.asset("assets/images/ArrowUpRight.png"),
      ],
    );
  }
}
