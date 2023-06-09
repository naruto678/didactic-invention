import 'package:flutter/material.dart';
import 'package:flutter_sqlite/add_category.dart';
import 'package:flutter_sqlite/contact_list.dart';
import 'package:flutter_sqlite/homepage.dart';

import 'colors.dart';

class MyDrawal extends StatelessWidget {
  const MyDrawal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 55),
      child: Drawer(
        backgroundColor: MyColors.drawalBackground,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text(
                'Add Occupation',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const HomePage()));
              },
            ),
            const Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Add Friend',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const AddCategory()));
              },
            ),
            const Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
            ListTile(
              title: const Text(
                'Friends List',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const ContactList()));
              },
            ),
            const Divider(
              color: MyColors.drawalDivider,
              height: 2,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
