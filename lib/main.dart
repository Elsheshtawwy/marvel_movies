import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:marvel/providers/auth_provider.dart';
import 'package:marvel/providers/base_provider.dart';
import 'package:marvel/providers/movies_providers.dart';
import 'package:marvel/screens/auth_screens/login_screen.dart';
import 'package:marvel/screens/auth_screens/splash_screen.dart';
import 'package:marvel/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseProvider>(
          create: (_) => BaseProvider(),
        ),
        ChangeNotifierProvider<MoviesProviders>(
          create: (_) => MoviesProviders(),
        ),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initializeAuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authConsumer, _) {
      return AnimatedSwitcher(
        duration: const Duration(microseconds: 300),
        child: authConsumer.isAuthed ? const HomeScreen() : const LoginScreen(),
      );
    });
  }
}
