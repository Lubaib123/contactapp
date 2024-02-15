import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/gen/assets.gen.dart';
import 'package:contacts_app/modules/contacts_detail_screen/contact_details_screen.dart';
import 'package:contacts_app/services/firestore.dart';
import 'package:contacts_app/theme/color_resources.dart';
import 'package:contacts_app/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: CircleAvatar(
                child: Image.asset(Assets.icon.profilePicDummy.keyName)),
          ),
          CupertinoButton(
              child: Icon(CupertinoIcons.settings),
              onPressed: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
              })
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Contacts",
            style: h1,
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FireStoreService().getContatsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List contactslist = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: contactslist.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = contactslist[index];
                    String docId = document.id;
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String name = data['name'];
                    String profileImage = data['profileImage'];
                    String number = data['phoneNumber'];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        child: Visibility(
                            visible: profileImage != null,
                            child: Image.network(profileImage)),
                      ),
                      title: Text(
                        name,
                        style: h2,
                      ),
                      subtitle: Text(
                        number,
                        style: h3,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoButton(
                              child: Text("Edit"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactScreen(
                                            docId: docId,
                                            name: name,
                                            phoneNumber: number,
                                            image: profileImage,
                                          )),
                                );
                              }),
                          IconButton(
                            onPressed: () =>
                                FireStoreService().deleteContact(docId),
                            icon: Icon(
                              CupertinoIcons.delete,
                              color: ColorResources.RED,
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: Text("No Contacts"));
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorResources.PRIMARY,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen()),
            );
          },
          label: Text(
            "+ Add contacts",
            style: body2.white,
          )),
    );
  }
}
