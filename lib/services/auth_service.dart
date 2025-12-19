import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  User? get currentUser => _auth.currentUser;
  Stream<User?> get userStream => _auth.authStateChanges();
  
  // Simpan data bookmark & todo di memori
  List<String> _bookmarkedIds = [];
  List<Map<String, dynamic>> _todos = [];
  
  List<String> get bookmarkedIds => _bookmarkedIds;
  List<Map<String, dynamic>> get todos => _todos;
  
  bool isBookmarked(String id) => _bookmarkedIds.contains(id);
  
  void toggleBookmark(String id) {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
  }
  
  void addTodo({
    required String title,
    required String description,
    String destinationName = '',
    String destinationLocation = '',
  }) {
    final newTodo = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'description': description,
      'destinationName': destinationName,
      'destinationLocation': destinationLocation,
      'createdAt': DateTime.now(),
      'completed': false,
    };
    
    _todos.add(newTodo);
    notifyListeners();
  }
  
  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo['id'] == id);
    if (index != -1) {
      _todos[index]['completed'] = !_todos[index]['completed'];
      notifyListeners();
    }
  }
  
  // ✅ METHOD BARU: Update Todo
  void updateTodo({
    required String id,
    required String title,
    String description = '',
  }) {
    final index = _todos.indexWhere((todo) => todo['id'] == id);
    if (index != -1) {
      _todos[index] = {
        ..._todos[index],
        'title': title,
        'description': description,
        'updatedAt': DateTime.now(),
      };
      notifyListeners();
    }
  }
  
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo['id'] == id);
    notifyListeners();
  }
  
  Future<void> signInWithEmail(String email, String password) async {
    try {
      print('🔄 Mencoba login dengan: $email');
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      print('✅ Login berhasil!');
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Email tidak terdaftar';
          break;
        case 'wrong-password':
          errorMessage = 'Password salah';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        case 'user-disabled':
          errorMessage = 'Akun dinonaktifkan';
          break;
        case 'too-many-requests':
          errorMessage = 'Terlalu banyak percobaan. Coba lagi nanti';
          break;
        default:
          errorMessage = 'Login gagal: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      print('❌ General Error: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }
  
  Future<void> signUpWithEmail(String email, String password, String name) async {
    try {
      print('🔄 Mencoba signup dengan: $email, name: $name');
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      await userCredential.user?.updateDisplayName(name.trim());
      await userCredential.user?.reload();
      
      print('✅ Signup berhasil! User: ${userCredential.user?.uid}');
      
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'Password terlalu lemah (minimal 6 karakter)';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email sudah digunakan';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Registrasi email/password tidak diizinkan';
          break;
        default:
          errorMessage = 'Registrasi gagal: ${e.message}';
      }
      throw Exception(errorMessage);
    } catch (e) {
      print('❌ General Error: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }
  
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _bookmarkedIds = [];
      _todos = [];
      notifyListeners();
      print('✅ Logout berhasil!');
    } catch (e) {
      print('❌ Logout Error: $e');
      throw Exception('Logout gagal: $e');
    }
  }
  
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      print('✅ Email reset password dikirim ke: $email');
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      throw Exception('Gagal mengirim reset password: ${e.message}');
    } catch (e) {
      print('❌ General Error: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}