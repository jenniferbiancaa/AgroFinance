
import 'package:app_finance/common/extensions/page_controller_ext.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  final PageController controller;
  final Color? selectedItemColor;
  final List<CustomBottomAppBarItem> children;
  const CustomBottomAppBar({
    Key? key,
    this.selectedItemColor,
    required this.children,
    required this.controller,
  })  : assert(children.length == 3, 'children.length must be 3'),
        super(key: key);

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map(
          (item) {
            bool currentItem;

            currentItem = widget.children.indexOf(item) ==
                widget.controller.selectedBottomAppBarItemIndex;
            return Builder(
              builder: (context) {
                return Expanded(
                  key: item.key,
                  child: InkWell(
                    onTap: item.onPressed,
                    onTapUp: (_) {
                      widget.controller.setBottomAppBarItemIndex =
                          widget.children.indexOf(item);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Icon(
                        currentItem ? item.primaryIcon : item.secondaryIcon,
                        color: currentItem
                            ? widget.selectedItemColor
                            : AppColors.lightGrey,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomBottomAppBarItem {
  final Key? key;
  final String? label;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final VoidCallback? onPressed;

  CustomBottomAppBarItem({
    this.key,
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });

  CustomBottomAppBarItem.empty({
    this.key,
    this.label,
    this.primaryIcon,
    this.secondaryIcon,
    this.onPressed,
  });
}