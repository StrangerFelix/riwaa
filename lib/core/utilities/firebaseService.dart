import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  // Firebase instances
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase firebaseDatabase;
  // final FirebaseStorage storage;

  // Private constructor
  FirebaseService._({
    required this.firebaseAuth,
    required this.firestore,
    required this.firebaseDatabase,
  });

  // Factory method for creating the service
  factory FirebaseService.initialize() {
    return FirebaseService._(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      firebaseDatabase: FirebaseDatabase.instance,
    );
  }
}