import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:piramid_game/presentation/layouts/app_shell.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  final List<String> criterios = const [
    "Resenha", "Presença VIP", "Aura", "Modo Parceiro",
    "Carisma Natural", "Humor de Milhões", "Energia de Grupo",
    "Criatividade Caótica", "Modo Atleta", "Talento de Palco",
    "Drip Escolar", "Coração de Dorama", "Queridinho dos Professores",
    "Cérebro Turbo", "Caos Controlado"
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sobre o PiramidGame",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text("Sistema de ranking de popularidade dos alunos do IFPR — Campus Paranaguá. Cada aluno recebe nota de 1 a 5 estrelas em 15 critérios."),
            const SizedBox(height: 24),
            _buildSectionCard(
              context,
              title: "Os 15 critérios",
              child: Wrap(
                spacing: 8, runSpacing: 8,
                children: criterios.map((c) => Chip(label: Text(c, style: const TextStyle(fontSize: 12)))).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              title: "A Escada para o Caos",
              child: Column(
                children: [
                  _buildLevelRow("15 - 24", "Mortal", AppColors.mortal),
                  _buildLevelRow("25 - 34", "Guerreiro", AppColors.guerreiro),
                  _buildLevelRow("35 - 44", "Elite", AppColors.elite),
                  _buildLevelRow("45 - 54", "Mestre", AppColors.mestre),
                  _buildLevelRow("55 - 64", "Lenda", AppColors.lenda),
                  _buildLevelRow("65 - 70", "Aura", AppColors.aura),
                  _buildLevelRow("71 - 75", "Chaos", AppColors.chaos),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              title: "Regras do Ranking",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBullet("Cada critério vale de 1 a 5 estrelas."),
                  _buildBullet("A soma total (15 a 75) define seu nível na pirâmide."),
                  _buildBullet("O ranking é automático e ordenado do maior para o menor score."),
                  _buildBullet("O Top 3 ganha medalhas 🥇 🥈 🥉."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelRow(String range, String level, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 12, color: color),
              const SizedBox(width: 8),
              Text(level, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          Text(range, style: const TextStyle(fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required String title, required Widget child}) {
    return Card(
      elevation: 0,
      // ignore: deprecated_member_use
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
