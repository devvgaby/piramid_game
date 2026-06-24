class AppMessages {
  static const error = _Error();
  static const success = _Success();
}

class _Error {
  const _Error();

  final String defaultError = 'Ocorreu um erro inesperado.';
  final String apiLocalError = 'Erro ao acessar o armazenamento local.';
  final String emptyResultError = 'Nenhum aluno encontrado.';

  final String studentNotFoundError = 'Aluno não encontrado.';
  final String studentUpdateError = 'Erro ao atualizar aluno.';
  final String studentDeleteError = 'Erro ao remover aluno.';
  final String studentSaveError = 'Erro ao salvar aluno.';

  final String invalidNameError = 'Nome é obrigatório.';
  final String invalidClassYearError = 'Turma deve estar entre 1998 e 2026.';
  final String invalidScoreError = 'Todos os critérios devem possuir nota entre 1 e 5.';
}

class _Success {
  const _Success();

  final String studentSaved = 'Aluno cadastrado com sucesso.';
  final String studentUpdated = 'Aluno atualizado com sucesso.';
  final String studentDeleted = 'Aluno removido com sucesso.';
}