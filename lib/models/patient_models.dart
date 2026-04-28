class Patient {
  Patient({
    required this.name,
    required this.age,
    required this.cpf,
    required this.lastConsult,
    required this.allergens,
    required this.conditions,
    required this.medications,
    required this.bloodType,
  });

  final String name;
  final int age;
  final String cpf;
  final String lastConsult;
  final List<String> allergens;
  final List<String> conditions;
  final List<String> medications;
  final String bloodType;
}

class Consultation {
  Consultation(this.title, this.subtitle, this.span);

  final String title;
  final String subtitle;
  final String span;
}

class ExamFile {
  ExamFile(this.name, this.type);

  final String name;
  final String type;
}
