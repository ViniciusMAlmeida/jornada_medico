import 'package:flutter/material.dart';
import '../models/patient_models.dart';

class PatientHeader extends StatelessWidget {
  const PatientHeader({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: const Color(0xFFD1FAE5),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.person_rounded,
              size: 42,
              color: Color(0xFF047857),
            ),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patient.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 48,
                children: [
                  Text(
                    '${patient.age} anos',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: 'CPF: ', style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: patient.cpf),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: 'Última consulta: ', style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: patient.lastConsult),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF30B595),
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Novo atendimento',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
