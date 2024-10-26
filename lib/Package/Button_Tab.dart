import 'package:flutter/material.dart';

import 'PackageConstants.dart';
import 'RippleEffect/RippleEffectContainer.dart';
import 'Text_Button.dart';
import 'Utils.dart';

class ButtonTab extends StatelessWidget with text_with_button, utils {
  const ButtonTab(
      {super.key,
      required this.listValue,
      required this.backgroundColor,
      required this.textColor,
      required this.onIndexChanged,
      required this.currentIndex,
      required this.inActiveBackgroundColor});
  final List<String> listValue;
  final Color backgroundColor;
  final Color textColor;
  final Color inActiveBackgroundColor;
  final ValueChanged<int> onIndexChanged;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listValue.length,
        itemBuilder: (context, index) {
          return Margin(
            margin: const EdgeInsets.only(right: 10),
            child: ClickEffect(
              onTap: () {
                onIndexChanged(index);
              },
              borderRadius: radius(50),
              child: Container(
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: currentIndex == index
                        ? backgroundColor
                        : inActiveBackgroundColor,
                    borderRadius: radius(50),
                    border: currentIndex == index
                        ? null
                        : Border.all(color: backgroundColor, width: 1)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      text(
                          text: listValue[index],
                          fontSize: 16,
                          textColor: currentIndex == index
                              ? textColor
                              : backgroundColor)
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
