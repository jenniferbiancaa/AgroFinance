import 'package:flutter/material.dart';

class CustomTexButton extends StatelessWidget {
  final List<Text> children;
  final VoidCallback? onPressed;
  const CustomTexButton({
    Key? key,
    required this.children,
    this.onPressed
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
     onPressed:onPressed,
     child: Row(
       mainAxisSize: MainAxisSize.min,
       mainAxisAlignment: MainAxisAlignment.center,
       children: children,
      ),
    );
  }
}


