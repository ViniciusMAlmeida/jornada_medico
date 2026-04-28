import 'package:flutter/material.dart';
import '../models/patient_models.dart';

class ExamSummaryBlock extends StatelessWidget {
  const ExamSummaryBlock({super.key, required this.exams});

  final List<ExamFile> exams;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Últimos exames', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        Column(
          children: exams.map((exam) => _ExamCard(name: exam.name)).toList(),
        ),
        // const SizedBox(height: 40),
        // Align(
        //   alignment: Alignment.center,
        //   child: const _LinkButton(label: 'Ver todos os exames'),
        // ),
      ],
    );
  }
}

class _ExamCard extends StatefulWidget {
  const _ExamCard({required this.name});

  final String name;

  @override
  State<_ExamCard> createState() => _ExamCardState();
}

class _ExamCardState extends State<_ExamCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        border: Border(
          bottom: BorderSide(color: const Color(0xFFE2E8F0)),
          top: BorderSide(color: const Color(0xFFE2E8F0)),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file_rounded, color: Color(0xFF0F172A)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.name,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.auto_awesome, color: Color(0xFF7C2AD5)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye, color: Color(0xFF30B595)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded, color: Color(0xFF30B595)),
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatefulWidget {
  const _LinkButton({required this.label});

  final String label;

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.content_paste_search,
        size: 24,
        color: Color(0xFF30B595),
      ),
      label: Text(
        widget.label,
        style: TextStyle(
          color: const Color(0xFF30B595),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}
