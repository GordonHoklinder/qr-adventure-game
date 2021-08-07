import 'package:flutter/material.dart';

Widget TextIcon(IconData icon, String text, BuildContext context,
    {void Function()? onPressed}) {
  return Container(
    height: 91,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPressed,
            iconSize: Theme.of(context).iconTheme.size as double,
            icon: Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
            ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 10,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  );
}
