import 'package:flutter/material.dart';
import '../models/patient_models.dart';
import 'health_data_block.dart';
import 'exam_summary_block.dart';
import 'consult_history_block.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.patient,
    required this.consultations,
    required this.exams,
    this.onEdit,
  });

  final Patient patient;
  final List<Consultation> consultations;
  final List<ExamFile> exams;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: HealthDataBlock(patient: patient, onEdit: onEdit),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ConsultHistoryBlock(consultations: consultations)),
            const SizedBox(width: 28),
            Expanded(child: ExamSummaryBlock(exams: exams)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.people,
                size: 24,
                color: Color(0xFF30B595),
              ),
              label: Text(
                'Ver todas as consultas',
                style: TextStyle(
                  color: const Color(0xFF30B595),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.content_paste_search,
                size: 24,
                color: Color(0xFF30B595),
              ),
              label: Text(
                'Ver todos os exames',
                style: TextStyle(
                  color: const Color(0xFF30B595),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
