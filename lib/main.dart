import 'package:flutter/material.dart';
import 'package:findme/screens/cadastro_usuario.dart';
import 'package:findme/screens/login.dart';
import 'package:findme/screens/lost_items_screen.dart';
import 'package:findme/screens/profile_screen.dart';
import 'package:findme/screens/recuperar_senha.dart';
import 'package:findme/screens/register_lost_item_screen.dart';
import 'package:findme/screens/sectors_screen.dart';

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
      
      // Define a rota inicial do app
      initialRoute: '/login',

      // Define todas as rotas nomeadas
      routes: {
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const CadastroUsuarioPage(),
        '/recuperar-senha': (context) => RecuperarSenhaPage(),
        '/lost_items': (context) => const LostItemsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/sectors': (context) => const SectorsScreen(),
        '/register_lost_item': (context) => const RegisterLostItemScreen(),
      },
    );
  }
}