import 'package:flutter/material.dart';
import 'models/patient_models.dart';
import 'widgets/sidebar.dart';
import 'widgets/patient_header.dart';
import 'widgets/tab_row.dart';
import 'widgets/summary_card.dart';
import 'widgets/edit_modal.dart';

void main() {
  runApp(const JornadaMedicoApp());
}

class JornadaMedicoApp extends StatelessWidget {
  const JornadaMedicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jornada Médico',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        primaryColor: const Color(0xFF30B595),
        splashFactory: InkRipple.splashFactory,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF30B595)),
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineSmall: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          titleMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
          bodyLarge: const TextStyle(fontSize: 16, color: Color(0xFF334155)),
          bodyMedium: const TextStyle(fontSize: 14, color: Color(0xFF475569)),
        ),
      ),
      home: const PatientProfilePage(),
    );
  }
}

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key});

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  final List<MenuItem> menuItems = [
    MenuItem('Página Inicial', Icons.home_rounded, true),
    MenuItem('Agenda', Icons.calendar_month_rounded),
    MenuItem('Pacientes', Icons.account_box),
    MenuItem('Notificações', Icons.notifications_active),
  ];

  final List<MenuItem> footerItems = [
    MenuItem('Meu Perfil', Icons.badge),
    MenuItem('Configurações', Icons.settings_rounded, false, Color(0xFF2A2A2A)),
    MenuItem('Sair', Icons.logout_rounded, false, Color(0xFFBB4045)),
  ];

  final List<String> tabs = [
    'Resumo',
    'Consultas',
    'Herograma',
    'Exames',
    'Dados Pessoais',
  ];
  int activeTabIndex = 0;
  bool editModalOpen = false;
  bool sidebarVisible = true;

  final Patient patient = Patient(
    name: 'Marcelo Araújo Silva',
    age: 28,
    cpf: '012.345.678-98',
    lastConsult: 'há 2 meses',
    allergens: ['Ovo', 'Dipirona', 'Ibuprofeno'],
    conditions: ['Asma', 'Hipertensão'],
    medications: ['Venlafaxina', 'Dipirona'],
    bloodType: 'Tipo O+',
  );

  final List<Consultation> consultations = [
    Consultation('Com você', 'Clínica Geral', '16 dias atrás'),
    Consultation('Dr. Rafael G.', 'Oftalmologista', '2 meses atrás'),
    Consultation('Dra. Mariana S.', 'Cardiologista', '2 meses atrás'),
  ];

  final List<ExamFile> exams = [
    ExamFile('Hemograma completo - 14-10-2025.pdf', 'pdf'),
    ExamFile('Urina - 14-10-2025.pdf', 'pdf'),
    ExamFile('Parasitológico - 22-02-2025.pdf', 'pdf'),
    ExamFile('Hemograma completo - 21-08-2024.pdf', 'pdf'),
    ExamFile('Endoscopia - 03-09-2024.pdf', 'pdf'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Row(
              children: [
                Sidebar(
                  menuItems: menuItems,
                  footerItems: footerItems,
                  onToggleSidebar: () =>
                      setState(() => sidebarVisible = !sidebarVisible),
                  isExpanded: sidebarVisible,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 32,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: size.width > 1400 ? 1100 : 980,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 1,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: Color(0xFFE2E8F0),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PatientHeader(patient: patient),
                                    const SizedBox(height: 24),
                                    TabRow(
                                      tabs: tabs,
                                      activeIndex: activeTabIndex,
                                      onTabSelected: (index) {
                                        setState(() {
                                          activeTabIndex = index;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 26),
                                    SummaryCard(
                                      patient: patient,
                                      consultations: consultations,
                                      exams: exams,
                                      onEdit: () =>
                                          setState(() => editModalOpen = true),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (editModalOpen)
            EditModal(
              patient: patient,
              onClose: () => setState(() => editModalOpen = false),
            ),
        ],
      ),
    );
  }
}
