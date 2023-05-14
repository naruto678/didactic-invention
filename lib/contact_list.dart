import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/edit_category.dart';
import 'package:flutter_sqlite/mydrawal.dart';

import 'colors.dart';
import 'db_manager.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allCategoryData = [];

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawal(),
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: const Text("Friends List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Text(""),
            Expanded(
                child: ListView.builder(
              itemCount: allCategoryData.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                var item = allCategoryData[index];
                Uint8List bytes = base64Decode(item['profile']);
                return Container(
                  color: MyColors.orangeTile,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(minRadius: 20,maxRadius: 25,child: Image.memory(bytes,fit: BoxFit.cover,),),
                          Text("${item['name']}"),
                          Text("${item['lname']}"),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              _edit(item['_id']);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _delete(item['_id']);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                      const Divider(
                        color: MyColors.orangeDivider,
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRowsofContact();
    print('query all rows:');
    allRows.forEach(print);
    allCategoryData = allRows;
    setState(() {});
  }


  void _edit(int id) async {
    print("calling edit on $id");
    
    final contacts = await dbHelper.queryAllRowsofContact(); 

    String firstName = ""; 
    String lastName = ""; 
    String emailAddress = ""; 
    String mobileNumber = "";
    String category = "";  
    print("These are the contacts"); 
    print(contacts); 
    for(int i = 0 ; i< contacts.length; i++){
      if(contacts[i]["_id"] ==id ) {
        firstName = contacts[i]["name"]; 
        lastName = contacts[i]["lname"]; 
        emailAddress = contacts[i]["email"]; 
        mobileNumber = contacts[i]["mobile"]; 
        category = contacts[i]["cat"]; 


        break;     
      }
    }
    final rowsDeleted = await dbHelper.deleteContact(id); 
    print("deletd $rowsDeleted during edit operation"); 
    Navigator.push(context, MaterialPageRoute(builder: (_)=>  EditCategory(firstName: firstName, lastName: lastName, mobileNumber: mobileNumber, emailAddress: emailAddress)));  
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.deleteContact(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }
}
