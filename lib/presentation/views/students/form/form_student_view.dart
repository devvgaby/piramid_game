import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../domain/models/student_entity.dart';
import '../../../layouts/app_shell.dart';
import '../../../widgets/input_text_field.dart';
import '../../../widgets/course_dropdown.dart';
import '../../../widgets/year_dropdown.dart';
import '../../../widgets/birth_date_picker.dart';
import '../../../widgets/star_rating.dart';
import '../../../widgets/student_attribute_title.dart';

class FormStudentView extends StatefulWidget {
  final StudentEntity? student;
  const FormStudentView({super.key, this.student});

  @override
  State<FormStudentView> createState() => _FormStudentViewState();
}

class _FormStudentViewState extends State<FormStudentView> {
  final _nameCtrl = TextEditingController();
  final _nicknameCtrl = TextEditingController();

  StudentCourse _course = StudentCourse.INFO;
  int _classYear = DateTime.now().year;
  DateTime? _birthDate;

  final Map<String, int> _scores = {
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

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    if (s != null) {
      _nameCtrl.text = s.name;
      _nicknameCtrl.text = s.nickname;
      _course = s.course;
      _classYear = s.classYear;
      _birthDate = s.birthDate;
      _scores['resenha'] = s.resenha;
      _scores['presencaVip'] = s.presencaVip;
      _scores['aura'] = s.aura;
      _scores['modoParceiro'] = s.modoParceiro;
      _scores['carismaNatural'] = s.carismaNatural;
      _scores['humorMilhoes'] = s.humorMilhoes;
      _scores['energiaGrupo'] = s.energiaGrupo;
      _scores['criatividadeCaotica'] = s.criatividadeCaotica;
      _scores['modoAtleta'] = s.modoAtleta;
      _scores['talentoPalco'] = s.talentoPalco;
      _scores['dripEscolar'] = s.dripEscolar;
      _scores['coracaoDorama'] = s.coracaoDorama;
      _scores['queridinhoProfessores'] = s.queridinhoProfessores;
      _scores['cerebroTurbo'] = s.cerebroTurbo;
      _scores['caosControlado'] = s.caosControlado;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _nicknameCtrl.dispose();
    super.dispose();
  }

  int get _total => _scores.values.fold(0, (a, b) => a + b);

  String get _levelName {
    final l = _total;
    if (l <= 24) return 'Mortal';
    if (l <= 34) return 'Guerreiro';
    if (l <= 44) return 'Elite';
    if (l <= 54) return 'Mestre';
    if (l <= 64) return 'Lenda';
    if (l <= 70) return 'Aura';
    return 'Chaos';
  }

  Color get _levelColor {
    final l = _total;
    if (l <= 24) return AppColors.mortal;
    if (l <= 34) return AppColors.guerreiro;
    if (l <= 44) return AppColors.elite;
    if (l <= 54) return AppColors.mestre;
    if (l <= 64) return AppColors.lenda;
    if (l <= 70) return AppColors.aura;
    return AppColors.chaos;
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nome é obrigatório')));
      return;
    }
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data de nascimento é obrigatória')));
      return;
    }
    setState(() => _saving = true);

    final student = StudentEntity(
      id: widget.student?.id ?? const Uuid().v4(),
      name: _nameCtrl.text.trim(),
      nickname: _nicknameCtrl.text.trim(),
      course: _course,
      classYear: _classYear,
      birthDate: _birthDate!,
      resenha: _scores['resenha']!,
      presencaVip: _scores['presencaVip']!,
      aura: _scores['aura']!,
      modoParceiro: _scores['modoParceiro']!,
      carismaNatural: _scores['carismaNatural']!,
      humorMilhoes: _scores['humorMilhoes']!,
      energiaGrupo: _scores['energiaGrupo']!,
      criatividadeCaotica: _scores['criatividadeCaotica']!,
      modoAtleta: _scores['modoAtleta']!,
      talentoPalco: _scores['talentoPalco']!,
      dripEscolar: _scores['dripEscolar']!,
      coracaoDorama: _scores['coracaoDorama']!,
      queridinhoProfessores: _scores['queridinhoProfessores']!,
      cerebroTurbo: _scores['cerebroTurbo']!,
      caosControlado: _scores['caosControlado']!,
    );

    if (widget.student == null) {
      await studentsViewModel.commands.saveStudent(student);
    } else {
      await studentsViewModel.commands.updateStudent(student);
    }

    setState(() => _saving = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.student != null;

    return AppShell(
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(editing ? 'Editar aluno' : 'Cadastrar aluno',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            _SectionCard(
              title: 'Dados do aluno',
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'Nome',
                          controller: _nameCtrl,
                          isRequired: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InputTextField(
                          label: 'Apelido',
                          controller: _nicknameCtrl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CourseDropdown(
                          value: _course,
                          onChanged: (v) => setState(() => _course = v),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: YearDropdown(
                          value: _classYear,
                          onChanged: (v) => setState(() => _classYear = v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BirthDatePicker(
                    value: _birthDate,
                    onChanged: (v) => setState(() => _birthDate = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _SectionCard(
              title: 'Critérios de Popularidade',
              subtitle: 'Avalie de 1 a 5 estrelas. A soma forma o Nível Lenda (15–75).',
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 3.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 8,
                    children: _scores.keys.map((key) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: StudentAttributeTitle(label: _labels[key]!),
                          ),
                          StarRating(
                            value: _scores[key]!,
                            onChanged: (v) => setState(() => _scores[key] = v),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _levelColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _levelColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('NÍVEL LENDA',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                            Row(
                              children: [
                                Text('$_total',
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: _levelColor)),
                                Text('/75',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.4))),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _levelColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(_levelName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _levelColor,
                                  fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: _saving
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : Text(editing ? 'Salvar alterações' : 'Cadastrar aluno',
                        style: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  const _SectionCard({required this.title, this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!,
                style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5))),
          ],
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}