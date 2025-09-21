import 'package:findme/screens/item_detail_screen.dart';
import 'package:findme/screens/register_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:findme/screens/cadastro_usuario.dart';
import 'package:findme/screens/login.dart';
import 'package:findme/screens/lost_items_screen.dart';
import 'package:findme/screens/profile_screen.dart';
import 'package:findme/screens/recuperar_senha.dart';
import 'package:findme/screens/register_lost_item_screen.dart';
import 'package:findme/screens/sectors_screen.dart';
import 'package:findme/screens/main_screen.dart'; // Mude "findme" se necessário

void main() {
  runApp(const FindMeApp());
}

class FindMeApp extends StatelessWidget {
  const FindMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find me',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const CadastroUsuarioPage(),
        '/main': (context) => const MainScreen(),
        '/recuperar-senha': (context) => RecuperarSenhaPage(),
        '/lost_item': (context) => const LostItemsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/sectors': (context) => const SectorsScreen(),
        '/register_lost_item': (context) => const RegisterLostItemScreen(),
        '/detail': (context) => const ItemDetailScreen(),
        '/register': (context) => const RegisterItemScreen(),
      },
    );
  }
}