import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guest_book_message.dart';
import 'dart:async';
import '../firebase_options.dart';

enum Attending { yes, no, unknown }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  int _attendees = 0;
  int get attendees => _attendees;

  Attending _attending = Attending.unknown;
  Attending get attending => _attending;
  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set({'attending': true});
    } else {
      userDoc.set({'attending': false});
    }
  }

  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;

        final currentUser = FirebaseAuth.instance.currentUser!;
        if (currentUser.displayName == null ||
            currentUser.displayName!.isEmpty) {
          final name = currentUser.email?.split('@')[0] ?? 'Guest';
          currentUser.updateDisplayName(name);
        }

        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final document in snapshot.docs) {
            final data = document.data() as Map<String, dynamic>;
            _guestBookMessages.add(
              GuestBookMessage(
                name: data['name']?.toString() ?? 'Anonymous',
                message: data['text']?.toString() ?? '',
              ),
            );
          }
          notifyListeners();
        });

        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            final data = snapshot.data()!;
            _attending =
                (data['attending'] == true) ? Attending.yes : Attending.no;
          } else {
            _attending = Attending.unknown;
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _guestBookMessages = [];
        _attending = Attending.unknown;
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }

      notifyListeners();
    });
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    final user = FirebaseAuth.instance.currentUser!;
    final name = user.displayName ?? user.email?.split('@')[0] ?? 'Guest';

    return FirebaseFirestore.instance.collection('guestbook').add({
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': name,
      'userId': user.uid,
    });
  }
}
