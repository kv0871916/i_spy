import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:i_spy/auth/views/common/common_auth.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  UserCredential? _userCredential;
  bool _isLoggedIn = false;
  bool _isVerified = false;
  String? _isError;

  bool get isLoading => _isLoading;
  String? get isError => _isError;
  bool get isVerified => _isVerified;
  UserCredential? get userCredential => _userCredential;
  bool get isLoggedIn => _isLoggedIn;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  logout() async {
    _isLoggedIn = false;
    _userCredential = null;
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  login({required String email, required String password}) async {
    _isError = '';
    try {
      setLoading(true);
      if (kDebugMode) print('User created 1: $_userCredential');
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) print('User created 2: $_userCredential');
      if (userCredential!.user != null) {
        if (kDebugMode) print('User created 3: ${_userCredential!.user}');
        setLoggedIn(true);

        _isVerified =
            userCredential!.user!.emailVerified ? true : await verifyemail();

        if (_isVerified) {
          setLoading(false);
        } else {
          setLoading(false);
          if (kDebugMode) print('User Error: Email not verified');
          _isError = 'Email not verified';
        }
        setLoading(false);
      } else {
        setLoading(false);
        if (kDebugMode) print('User Error: User not created');
        _isError = 'User not created';
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setLoggedIn(false);
        if (kDebugMode) print('User Error: No user found for that email.');
        _isError = 'No user found for that email.';
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        setLoggedIn(false);
        if (kDebugMode) {
          print('User Error: Wrong password provided for that user.');
        }
        _isError = 'Wrong password provided for that user.';
        notifyListeners();
      } else if (e.code == 'weak-password') {
        setLoggedIn(false);
        if (kDebugMode) print('User Error: The password provided is too weak.');
        _isError = 'The password provided is too weak.';
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        setLoggedIn(false);
        if (kDebugMode) {
          print('User Error: The account already exists for that email.');
        }
        _isError = 'The account already exists for that email.';
        notifyListeners();
      }
    } catch (e) {
      setLoggedIn(false);
      if (kDebugMode) print('User Error: catch $e');
      _isError = 'Something went wrong, please try again later.';
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
  }

  register(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      setLoading(true);
      if (kDebugMode) print('User created 1: $_userCredential');
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) print('User created 2: $_userCredential');
      if (userCredential!.user != null) {
        if (kDebugMode) print('User created 3: ${_userCredential!.user}');
        setLoggedIn(true);
        bool verified = await verifyemail();
        _isVerified = verified;
        if (verified) {
          await customAlretDialog(
              title: 'Email Verification',
              message: 'Email sent',
              context: context);

          setLoading(false);
        } else {
          _isError = ' Email not verified';
          setLoading(false);
          if (kDebugMode) print('User Error: Email not verified');
        }
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        _isError = ' User not created';
        if (kDebugMode) print('User Error: User not created');
        notifyListeners();
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setLoggedIn(false);
        if (kDebugMode) print('User Error: No user found for that email.');
        _isError = ' No user found for that email.';
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        setLoggedIn(false);
        if (kDebugMode) {
          print('User Error: Wrong password provided for that user.');
        }
        _isError = ' Wrong password provided for that user.';
        notifyListeners();
      } else if (e.code == 'weak-password') {
        setLoggedIn(false);
        if (kDebugMode) print('User Error: The password provided is too weak.');
        _isError = ' The password provided is too weak.';
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        setLoggedIn(false);
        if (kDebugMode) {
          print('User Error: The account already exists for that email.');
        }
        _isError = ' The account already exists for that email.';
        notifyListeners();
      }
    } catch (e) {
      setLoggedIn(false);
      if (kDebugMode) print('User Error: catch $e');
      _isError = 'Something went wrong, please try again later.';
      notifyListeners();
    }
    setLoading(false);
    notifyListeners();
  }

  Future<bool> verifyemail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      setLoggedIn(true);
      return true;
    } else {
      setLoggedIn(false);
      return false;
    }
  }
}
