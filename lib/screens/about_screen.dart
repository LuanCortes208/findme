// DENTRO DO ARQUIVO: lib/screens/about_screen.dart

import 'package:flutter/material.dart';

// Modelo de dados para organizar as informações de cada desenvolvedor.
class Developer {
  final String name;
  final String course;
  final String period;
  final String contribution;
  final String description;
  final String imagePath; // Caminho para a imagem na pasta assets

  const Developer({
    required this.name,
    required this.course,
    required this.period,
    required this.contribution,
    required this.description,
    required this.imagePath,
  });
}

// Lista com os dados da sua equipe.
// EDITE ESTA LISTA COM AS INFORMAÇÕES DO SEU GRUPO!
final teamMembers = [
  const Developer(
    name: 'Luan Cortes',
    course: 'Análise e Desenvolvimento de Sistemas',
    period: '5º Período',
    contribution: 'Desenvolvedor',
    description: 'Ficou responsável pela programação e dar suporte ao time em suas atividades.',
    imagePath: 'assets/images/STK-20250921-WA0004.jpg', 
  ),
  const Developer(
    name: 'Katiane Ribeiro',
    course: 'Análise e Desenvolvimento de Sistemas',
    period: '5º Período',
    contribution: 'Desenvolvedor',
    description: 'Ficou responsável pela parte por programar, revisar o código e aprovar o envio.',
    imagePath: 'assets/images/STK-20250921-WA0002.jpg', 
  ),
  const Developer(
    name: 'Willian Santana',
    course: 'Análise e Desenvolvimento de Sistemas',
    period: '5º Período',
    contribution: 'Desenvolvedor',
    description: 'Ficou responsável por documentar e programar.',
    imagePath: 'assets/images/STK-20250921-WA0001.jpg', 
  ),
  const Developer(
    name: 'Bianca Arielly',
    course: 'Análise e Desenvolvimento de Sistemas',
    period: '5º Período',
    contribution: 'Desenvolvedor',
    description: 'Ficou responsável por programar e definir o design das telas.',
    imagePath: 'assets/images/STK-20250921-WA0005.jpg', 
  ),
];


class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Esta linha faz a tela "voltar"
          },
        ),
        title: const Text('Sobre o App e a Equipe'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Seção "Sobre o App"
          _buildAppInfoCard(),
          const SizedBox(height: 24),

          // Título da seção da equipe
          const Text(
            'Equipe de Desenvolvimento',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Lista de membros da equipe
          ...teamMembers.map((member) => _buildDeveloperCard(member)).toList(),
        ],
      ),
    );
  }

  // Card com informações sobre o aplicativo
  Widget _buildAppInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Me - Achados e Perdidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Este aplicativo foi desenvolvido como projeto para a disciplina de Tecnologias Mobile da Universidade Tiradentes (UNIT). O objetivo é criar uma solução centralizada para o problema de itens perdidos no ambiente universitário, conectando quem perdeu com quem encontrou de forma simples e eficiente.',
              style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  // Card para cada membro da equipe
  Widget _buildDeveloperCard(Developer member) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // ALTERAÇÃO: Adicionado o alinhamento à esquerda para toda a coluna.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Centraliza a foto com o texto
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(member.imagePath),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${member.course} - ${member.period}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoRow('Contribuição:', member.contribution),
            const SizedBox(height: 12),
            _buildInfoRow('Sobre:', member.description),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para as linhas de informação (não precisa de alteração)
  Widget _buildInfoRow(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
        ),
      ],
    );
  }
}