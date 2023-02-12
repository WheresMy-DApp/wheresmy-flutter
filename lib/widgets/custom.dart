import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget customButton(String text,
    {required Function() onTap,
    bool isFilled = true,
    Color textColor = const Color(0xFFF3F3F3)}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        border: isFilled ? null : Border.all(color: const Color(0xFFF3F3F3)),
        borderRadius: BorderRadius.circular(10),
        gradient: isFilled
            ? const LinearGradient(
                colors: <Color>[
                  Color(0xFF9C77F5),
                  Color(0xFF7751F1),
                ],
              )
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}

Widget customTextFormField(TextEditingController controller, String label,
    {IconData? suffixIcon, bool isObscure = false, Color? borderColor}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure,
    decoration: InputDecoration(
      suffixIcon: Icon(
        suffixIcon,
        color: const Color(
          0xFF9C9C9C,
        ),
      ),
      filled: true,
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(
          0xFF9C9C9C,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: borderColor == null
            ? BorderSide.none
            : const BorderSide(
                color: Color(
                  0xFF9C9C9C,
                ),
              ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      // border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: borderColor == null
            ? BorderSide.none
            : const BorderSide(
                color: Color(
                  0xFF9C9C9C,
                ),
              ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: borderColor == null
            ? BorderSide.none
            : const BorderSide(
                color: Color(
                  0xFF9C9C9C,
                ),
              ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: borderColor == null
            ? BorderSide.none
            : const BorderSide(
                color: Color(
                  0xFF9C9C9C,
                ),
              ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      disabledBorder: InputBorder.none,
      fillColor: const Color(
        0xFF191919,
      ),
    ),
  );
}

AppBar customAppBar(
    {required BuildContext context, PreferredSizeWidget? bottom}) {
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    leading: Image.asset(
      "assets/logos/small.png",
    ),
    title: Text(
      "My Devices",
      style: Theme.of(context).textTheme.headline2,
    ),
    centerTitle: false,
    bottom: bottom,
  );
}

// Custom Tab Bar
TabBar customAppBarTab(
    {required TabController tabController, required List<Widget> tabs}) {
  return TabBar(
    controller: tabController,
    tabs: tabs,
    indicatorColor: Colors.transparent,
  );
}

Tab customTab({
  required SvgPicture leading,
  required String title,
}) {
  return Tab(
    child: SizedBox(
      child: Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: leading,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    ),
  );
}
