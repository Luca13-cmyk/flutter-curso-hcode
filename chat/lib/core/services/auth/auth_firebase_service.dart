import 'dart:async';

import 'dart:io';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage_web/firebase_storage_web.dart';

class AuthFirebaseService implements AuthService {
  static UserCredential? _credential;
  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;

    _credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (_credential!.user == null) return;

    // 1. Upload user photo
    final imageName = '${_credential!.user!.uid}.jpg';
    final imageURL = await _uploadUserImage(image, imageName);

    // 2. Update data user in firebase auth
    await _credential!.user?.updateDisplayName(name);
    await _credential!.user?.updatePhotoURL(imageURL);

    // FixedBug att data user in local
    _currentUser = _toChatUser(_credential!.user!, name, imageURL);

    // 3. save user in firestore
    await _saveChatUser(_currentUser!);
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    // _credential!.user?.updateDisplayName('julia');
    // print(_credential);
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() => {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);
    return docRef.set(
      {
        'name': user.name,
        'email': user.email,
        'imageURL': user.imageURL,
      },
    );
  }

  static ChatUser _toChatUser(User user, [String? name, String? imageURL]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
