# 🏆 PiramidGame IFPR - Paranaguá

> Sistema de ranking de popularidade desenvolvido em Flutter para a disciplina de Dispositivos Móveis do IFPR – Campus Paranaguá.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart" /
  <img src="https://img.shields.io/badge/License-MIT-green" />
</p>

---

## 📖 Sobre o projeto

O **PiramidGame** é um sistema de ranking fictício desenvolvido para organizar alunos do **IFPR – Campus Paranaguá** com base em um conjunto de critérios de popularidade.

Cada estudante recebe uma nota de **1 a 5 estrelas** em **15 critérios**, formando o chamado **Nível Lenda**, que determina sua posição no ranking.

O projeto foi desenvolvido utilizando **Flutter**, seguindo boas práticas de arquitetura e componentização, inspirado em aplicações modernas construídas com React e Material Design 3.

---

## ✨ Funcionalidades

### ✅ Implementadas

- Splash Screen
- Home Screen
- Tema claro e escuro
- Navegação entre telas
- Estrutura de Layout (AppShell)
- Arquitetura em camadas
- Componentização da interface

### 🚧 Em desenvolvimento

- Cadastro de alunos
- Editar aluno
- Remover aluno
- Visualizar detalhes
- Ranking automático
- Ordenação por pontuação
- Sistema de estrelas (1–5)
- Cálculo automático do Nível
- Persistência de dados
- Responsividade Web/Desktop

---

# 🧮 Como funciona o ranking

Cada aluno recebe notas entre **1 e 5** nos seguintes critérios:

- Resenha
- Presença VIP
- Aura
- Modo Parceiro
- Carisma Natural
- Humor Milhões
- Energia do Grupo
- Criatividade Caótica
- Modo Atleta
- Talento de Palco
- Drip Escolar
- Coração Dorama
- Queridinho dos Professores
- Cérebro Turbo
- Caos Controlado

A soma desses critérios gera o **Nível Lenda**, cuja pontuação varia entre:

```
Mínimo: 15 pontos
Máximo: 75 pontos
```

Os alunos são automaticamente ordenados do maior para o menor nível.

---

# 🏅 Classificação

| Pontuação | Nível |
|-----------|--------|
| 15 – 24 | Mortal |
| 25 – 34 | Guerreiro |
| 35 – 44 | Elite |
| 45 – 54 | Mestre |
| 55 – 64 | Lenda |
| 65 – 75 | Chaos |

---

# 📱 Telas

- Splash
- Home
- Alunos
- Cadastro
- Edição
- Detalhes
- Ranking
- Sobre

---

# 🎨 Design

O projeto utiliza um visual inspirado em aplicações modernas como:

- Lovable
- Shadcn UI
- Material Design 3

Características:

- Dark Mode
- Light Mode
- Cards modernos
- Bordas arredondadas
- Cor primária roxa
- Layout responsivo
- Componentes reutilizáveis

---

# 📂 Estrutura do projeto

```
lib/
│
├── core/
│   ├── routes/
│   ├── theme/
│   └── utils/
│
├── data/
│   ├── datasource/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── models/
│   ├── repositories/
│   ├── services/
│   └── usecases/
│
├── presentation/
│   ├── layout/
│   │    └── app_shell.dart
│   │
│   ├── views/
│   │    ├── splash/
│   │    ├── home/
│   │    ├── about/
│   │    ├── ranking/
│   │    └── students/
│   │
│   ├── viewmodels/
│   │
│   └── widgets/
│        ├── app_drawer.dart
│        ├── birth_date_picker.dart
│        ├── course_dropdown.dart
│        ├── empty_state.dart
│        ├── input_text_field.dart
│        ├── loading_indicator.dart
│        ├── ranking_card.dart
│        ├── star_rating.dart
│        ├── student_attributes_title.dart
│        ├── student_card.dart
│        └── year_dropdown.dart
│
└── main.dart
```

---

# 🛠 Tecnologias

- Flutter
- Dart
- Clean Architecture
- MVVM

---

# 📐 Arquitetura

O projeto segue uma arquitetura baseada em **MVVM**, organizada em camadas para facilitar manutenção, escalabilidade e reutilização de código.

```
Presentation
      │
      ▼
 ViewModel
      │
      ▼
 Repository
      │
      ▼
    Domain
```

---

# 📊 Fluxo da aplicação

```
Splash
      │
      ▼
Home
 ├── Alunos
 │      ├── Lista
 │      ├── Cadastro
 │      ├── Detalhes
 │      └── Editar
 │
 ├── Ranking
 │
 └── Sobre
```

---

# 🚀 Como executar

Clone o projeto:

```bash
git clone https://github.com/seu-usuario/piramidgame.git
```

Entre na pasta:

```bash
cd piramidgame
```

Instale as dependências:

```bash
flutter pub get
```

Execute:

```bash
flutter run
```

---
