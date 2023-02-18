import 'package:flutter/material.dart';
import 'package:wheresmy/widgets/custom.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  late bool isLoading;

  late TextEditingController deviceNicknameTextController;

  @override
  void initState() {
    isLoading = true;
    deviceNicknameTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: () {
          setState(() {
            isLoading = !isLoading;
          });
        },
        child: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add Device",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  _addingUI(),
                  isLoading
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: SizedBox(
                                // width: 343,
                                height: 56,
                                child: customButton(
                                  "Add Device",
                                  onTap: () {},
                                ),
                              )),
                        ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _addingUI() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.50,
      margin: const EdgeInsets.only(
        top: 75,
      ),
      decoration: const BoxDecoration(
          color: Color(0xFF191919),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "This Device",
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            isLoading
                ? "Your Device is being registered"
                : "Your Device is registered",
            style: isLoading
                ? Theme.of(context).textTheme.bodyText2
                : Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: const Color(0xFF37CDAF),
                    ),
          ),
          Stack(
            children: [
              Container(
                width: 178,
                height: 178,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF080808),
                ),
                child: Image.asset(
                  isLoading
                      ? "assets/logos/working.png"
                      : "assets/logos/iphone.png",
                  width: 178,
                  height: 178,
                ),
              ),
              isLoading
                  ? const SizedBox(
                      width: 178,
                      height: 178,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF9C77F5),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          Text(
            isLoading ? "Well, this may take a while" : "Model",
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: const Color(0xFF9C9C9C),
                ),
          ),
          isLoading
              ? const SizedBox()
              : const Text(
                  "iPhone 13 Pro Max",
                ),
          isLoading
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: customTextFormField(
                    deviceNicknameTextController,
                    "Device Nickname",
                    borderColor: const Color(0xFF393939),
                  )),
        ],
      ),
    );
  }
}
