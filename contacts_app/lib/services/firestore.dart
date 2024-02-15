import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  final CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');
//CREATE : adding new contact
  Future<void> addingContacts(
      String name, phoneNumber, countryCode, profileImage) {
    return contacts.add({
      'name': name,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'time': DateTime.now(),
      'userId': FirebaseAuth.instance.currentUser?.uid.toString()
    });
  }

//READ : listing contacts on homescreen
  Stream<QuerySnapshot> getContatsStream() {
    final contactsStream = contacts
        .orderBy('userId')
        .orderBy('time', descending: true)
        .snapshots();
    return contactsStream;
  }

//UPDATE: editing contacts
  Future<void> updatecontact(
      String docId, String name, phoneNumber, countryCode, profileImage) {
    return contacts.doc(docId).update({
      'name': name,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'time': DateTime.now(),
      'userId': FirebaseAuth.instance.currentUser?.uid.toString()
    });
  }

//DELETE: deleting contacts
  Future<void> deleteContact(
    String docId,
  ) {
    return contacts.doc(docId).delete();
  }
}
