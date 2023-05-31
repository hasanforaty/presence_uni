import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final void Function() onPressed;
  final IconData iconData;
  final String name;
  final bool isActive;
  final EdgeInsets padding;
  const DrawerItem(
      {Key? key,
      required this.onPressed,
      required this.iconData,
      required this.name,
      this.padding = const EdgeInsets.only(top: 8),
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
          onPressed: isActive ? onPressed : null,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, onSurface: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: MediaQuery.of(context).size.width * 0.125,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Text(
                  name,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          )),
    );
  }
}
