import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  // Firebase instances
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  // final FirebaseStorage storage;

  // Private constructor
  FirebaseService._({
    required this.firebaseAuth,
    required this.firestore,
  });

  // Factory method for creating the service
  factory FirebaseService.initialize() {
    return FirebaseService._(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    );
  }
}