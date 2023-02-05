import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final void Function() onPressed;
  final IconData iconData;
  final String name;
  final bool isActive;
  const DrawerItem(
      {Key? key,
      required this.onPressed,
      required this.iconData,
      required this.name,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
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
