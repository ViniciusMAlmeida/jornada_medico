import 'package:flutter/material.dart';
import '../models/patient_models.dart';

class ConsultHistoryBlock extends StatelessWidget {
  const ConsultHistoryBlock({super.key, required this.consultations});

  final List<Consultation> consultations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Histórico de Consultas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        Column(
          children: consultations
              .map(
                (consult) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ConsultationRow(consultation: consult),
                ),
              )
              .toList(),
        ),
        // const SizedBox(height: 16),
        // Align(
        //   alignment: Alignment.center,
        //   child: const _LinkButton(label: 'Ver todas as consultas'),
        // ),
      ],
    );
  }
}

class _ConsultationRow extends StatefulWidget {
  const _ConsultationRow({required this.consultation});

  final Consultation consultation;

  @override
  State<_ConsultationRow> createState() => _ConsultationRowState();
}

class _ConsultationRowState extends State<_ConsultationRow> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.consultation.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.consultation.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.consultation.span,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Ver prontuário',
                  style: TextStyle(
                    color: Color(0xFF30B595),
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF30B595),
                  ),
                ),
              ),
            ],
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
      icon: const Icon(Icons.people, size: 24, color: Color(0xFF30B595)),
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
