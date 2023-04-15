import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Readcontact extends StatefulWidget {
  const Readcontact({super.key});

  @override
  State<Readcontact> createState() => _ReadcontactState();
}

class _ReadcontactState extends State<Readcontact> {
   List<Contact>? contacts;


   getContact()async{
     if (await FlutterContacts.requestPermission()) {
      List<Contact> cnt = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);

      
      setState(() {
          contacts=cnt;
      });
    }
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),
      body:  (contacts) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: contacts!.length,
                itemBuilder: (BuildContext context, int index) {
                  //Uint8List? image = contacts![index].photo;
                  String num = (contacts![index].phones.isNotEmpty) ? (contacts![index].phones.first.number) : "--";
                  return ListTile(
                      title: Text(
                          "${contacts![index].name.first} ${contacts![index].name.last}"),
                      subtitle: Text(num),
                      );
                },
              )
              );
  }
}