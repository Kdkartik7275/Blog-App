import 'package:blog/core/utils/routes/route_name.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                onTap: () =>
                    Navigator.of(context).pushNamed(TRouteName.favourites),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    Text('Favourites', style: TextStyle(fontSize: 16)),
                  ],
                )),
          ];
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.menu, color: Color.fromRGBO(48, 48, 48, 1)),
        ));
  }
}
