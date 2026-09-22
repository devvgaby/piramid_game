import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/models/avaliacao_entity.dart';
import '../../../../domain/models/student_entity.dart';
import '../../../layouts/app_shell.dart';
import '../../../widgets/star_rating.dart';
import '../../../widgets/student_attribute_title.dart';

class AvaliarPessoaView extends StatefulWidget {
  final StudentEntity pessoa;
  const AvaliarPessoaView({super.key, required this.pessoa});

  @override
  State<AvaliarPessoaView> createState() => _AvaliarPessoaViewState();
}

class _AvaliarPessoaViewState extends State<AvaliarPessoaView> {
  final Map<String, int> _notas = {
    'resenha': 1, 'presencaVip': 1, 'aura': 1, 'modoParceiro': 1,
    'carismaNatural': 1, 'humorMilhoes': 1, 'energiaGrupo': 1,
    'criatividadeCaotica': 1, 'modoAtleta': 1, 'talentoPalco': 1,
    'dripEscolar': 1, 'coracaoDorama': 1, 'queridinhoProfessores': 1,
    'cerebroTurbo': 1, 'caosControlado': 1,
  };

  final Map<String, String> _labels = {
    'resenha': 'Resenha', 'presencaVip': 'Presença VIP', 'aura': 'Aura',
    'modoParceiro': 'Modo Parceiro', 'carismaNatural': 'Carisma Natural',
    'humorMilhoes': 'Humor de Milhões', 'energiaGrupo': 'Energia de Grupo',
    'criatividadeCaotica': 'Criatividade Caótica', 'modoAtleta': 'Modo Atleta',
    'talentoPalco': 'Talento de Palco', 'dripEscolar': 'Drip Escolar',
    'coracaoDorama': 'Coração de Dorama',
    'queridinhoProfessores': 'Queridinho dos Professores',
    'cerebroTurbo': 'Cérebro Turbo', 'caosControlado': 'Caos Controlado',
  };

  bool _loading = true;
  bool _saving = false;
  bool _bloqueado = false;
  AvaliacaoEntity? _avaliacaoExistente;

  int get _total => _notas.values.fold(0, (a, b) => a + b);

  @override
  void initState() {
    super.initState();
    _carregarAvaliacaoExistente();
  }

  Future<void> _carregarAvaliacaoExistente() async {
    final uid = authViewModel.currentUser.value?.uid;
    if (uid == null) return;

    if (uid == widget.pessoa.id) {
      setState(() {
        _bloqueado = true;
        _loading = false;
      });
      return;
    }

    final existente = await avaliacaoViewModel.buscarAvaliacaoExistente(
      avaliadorUid: uid,
      pessoaId: widget.pessoa.id,
    );

    if (existente != null) {
      _avaliacaoExistente = existente;
      _notas['resenha'] = existente.resenha;
      _notas['presencaVip'] = existente.presencaVip;
      _notas['aura'] = existente.aura;
      _notas['modoParceiro'] = existente.modoParceiro;
      _notas['carismaNatural'] = existente.carismaNatural;
      _notas['humorMilhoes'] = existente.humorMilhoes;
      _notas['energiaGrupo'] = existente.energiaGrupo;
      _notas['criatividadeCaotica'] = existente.criatividadeCaotica;
      _notas['modoAtleta'] = existente.modoAtleta;
      _notas['talentoPalco'] = existente.talentoPalco;
      _notas['dripEscolar'] = existente.dripEscolar;
      _notas['coracaoDorama'] = existente.coracaoDorama;
      _notas['queridinhoProfessores'] = existente.queridinhoProfessores;
      _notas['cerebroTurbo'] = existente.cerebroTurbo;
      _notas['caosControlado'] = existente.caosControlado;
    }

    setState(() => _loading = false);
  }

  Future<void> _salvar() async {
    final uid = authViewModel.currentUser.value?.uid;
    if (uid == null) return;

    setState(() => _saving = true);

    final avaliacao = AvaliacaoEntity(
      id: _avaliacaoExistente?.id ?? const Uuid().v4(),
      avaliadorUid: uid,
      pessoaId: widget.pessoa.id,
      dataAvaliacao: DateTime.now(),
      resenha: _notas['resenha']!,
      presencaVip: _notas['presencaVip']!,
      aura: _notas['aura']!,
      modoParceiro: _notas['modoParceiro']!,
      carismaNatural: _notas['carismaNatural']!,
      humorMilhoes: _notas['humorMilhoes']!,
      energiaGrupo: _notas['energiaGrupo']!,
      criatividadeCaotica: _notas['criatividadeCaotica']!,
      modoAtleta: _notas['modoAtleta']!,
      talentoPalco: _notas['talentoPalco']!,
      dripEscolar: _notas['dripEscolar']!,
      coracaoDorama: _notas['coracaoDorama']!,
      queridinhoProfessores: _notas['queridinhoProfessores']!,
      cerebroTurbo: _notas['cerebroTurbo']!,
      caosControlado: _notas['caosControlado']!,
    );

    final result = await avaliacaoViewModel.avaliarPessoaCommand.executeWith(avaliacao);

    setState(() => _saving = false);

    if (!mounted) return;

    result.fold(
      onSuccess: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avaliação salva com sucesso!')),
        );
        context.pop();
      },
      onFailure: (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.msg)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      showBackButton: true,
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _bloqueado
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'Você não pode avaliar a si mesmo.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Avaliar ${widget.pessoa.name}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        _avaliacaoExistente != null
                            ? 'Você já avaliou esta pessoa. Alterando sua avaliação anterior.'
                            : 'Dê de 1 a 5 estrelas em cada critério.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...(_notas.keys.map((key) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: StudentAttributeTitle(label: _labels[key]!),
                              ),
                              StarRating(
                                value: _notas[key]!,
                                onChanged: (v) => setState(() => _notas[key] = v),
                              ),
                            ],
                          ),
                        );
                      })),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('NÍVEL LENDA'),
                            Text('$_total/75',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _saving ? null : _salvar,
                          style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16)),
                          child: _saving
                              ? const SizedBox(
                                  height: 20, width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : Text(_avaliacaoExistente != null
                                  ? 'Salvar alterações'
                                  : 'Enviar avaliação'),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}