import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wisata_indonesia/screens/home_screen.dart';
import 'package:wisata_indonesia/screens/profile_screen.dart';
import 'package:wisata_indonesia/screens/todo_screen.dart';
import 'package:wisata_indonesia/screens/search_screen.dart';
import 'package:wisata_indonesia/screens/bookmark_screen.dart';
import 'package:wisata_indonesia/screens/login_screen.dart';
import 'package:wisata_indonesia/services/auth_service.dart';
import 'package:wisata_indonesia/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('🚀 Memulai Firebase...');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase berhasil diinisialisasi!');
    print('📱 Project: nusacerita');
  } catch (e) {
    print('❌ Gagal inisialisasi Firebase: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Wisata Indonesia',
            // PERBAIKAN: Gunakan ThemeData dengan primaryColor bukan primarySwatch
            theme: ThemeData(
              primaryColor: Colors.blue,
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.lightBlue,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                centerTitle: true,
              ),
            ),
            darkTheme: ThemeData(
              primaryColor: Colors.blue[300],
              colorScheme: const ColorScheme.dark(
                primary: Colors.blue,
                secondary: Colors.lightBlue,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF121212),
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
              ),
            ),
            themeMode: themeService.themeMode,
            home: const AuthWrapper(),
            debugShowCheckedModeBanner: false,
            routes: {
              '/home': (context) => const MainScreen(),
              '/search': (context) => const SearchScreen(),
              '/bookmark': (context) => const BookmarkScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/todo': (context) => const TodoScreen(),
              '/login': (context) => const LoginScreen(),
            },
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return StreamBuilder(
      stream: authService.userStream,
      builder: (context, snapshot) {
        print('🔍 AuthWrapper State: ${snapshot.connectionState}');
        print('🔍 Ada Data: ${snapshot.hasData}');
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('⏳ Menampilkan SplashScreen...');
          return const SplashScreen();
        }
        
        if (snapshot.hasError) {
          print('❌ Auth Error: ${snapshot.error}');
          return const LoginScreen();
        }
        
        if (snapshot.hasData) {
          print('✅ Pengguna terautentikasi: ${snapshot.data?.email}');
          return const MainScreen();
        }
        
        print('👤 Tidak ada pengguna, menampilkan LoginScreen');
        return const LoginScreen();
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.travel_explore,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Wisata Indonesia',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TodoScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          print('📱 BottomNav diklik: $index');
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Tersimpan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}