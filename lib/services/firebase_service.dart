import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireclassifieds/models/ad.dart';
import 'package:flutter/rendering.dart';

class FirebaseService {
  static init() async {
    await Firebase.initializeApp();
  }

  static signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await signUp(email, password);
      } else if (e.code == 'wrong-password') {
        throw FlutterError('Wrong password provided for that user.');
      }
    }
  }

  static signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw FlutterError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw FlutterError('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static CollectionReference<Ad> getAdsRef() {
    return FirebaseFirestore.instance.collection('ads').withConverter<Ad>(
          fromFirestore: (snapshot, _) => Ad.fromJson(snapshot.data()),
          toFirestore: (ad, _) => ad.toJson(),
        );
  }

  static createAd(Ad ad) async {
    await getAdsRef().add(ad);
  }

  static Future<List<QueryDocumentSnapshot<Ad>>> getAds(bool isMyAds) async {
    if (isMyAds) {
      return await getAdsRef()
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((snap) => snap.docs);
    }
    return await getAdsRef().get().then((snap) => snap.docs);
  }

  static deleteAd(String id) async {
    await getAdsRef().doc(id).delete();
  }
}
