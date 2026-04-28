import 'package:flutter/material.dart';
import '../models/patient_models.dart';

class HealthDataBlock extends StatelessWidget {
  const HealthDataBlock({super.key, required this.patient, this.onEdit});

  final Patient patient;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dados de Saúde',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (onEdit != null)
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Editar perfil'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF30B595),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alergias',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Icon(Icons.emergency, color: const Color(0xFFE63946)),
                      ...patient.allergens.map(
                        (allergy) => _DataTag(
                          label: allergy,
                          background: const Color(0xFFFEE2E0),
                          textColor: const Color(0xFFE63946),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Condições clínicas de saúde',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Icon(Icons.coronavirus, color: const Color(0xFFE67835)),
                      ...patient.conditions.map(
                        (condition) => _DataTag(
                          label: condition,
                          background: const Color(0xFFFFEDD5),
                          textColor: const Color(0xFFE67835),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remédios recorrentes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Icon(Icons.medication, color: const Color(0xFF4B90E0)),
                      ...patient.medications.map(
                        (med) => _DataTag(
                          label: med,
                          background: const Color(0xFFDBEAFE),
                          textColor: const Color(0xFF4B90E0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Tipo sanguíneo',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      const Icon(Icons.bloodtype_rounded, color: Color(0xFFB1273C)),
                      Text( 
                        patient.bloodType,
                        style: TextStyle(
                          color: const Color(0xFFB1273C),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DataTag extends StatelessWidget {
  const _DataTag({
    required this.label,
    required this.background,
    required this.textColor,
  });

  final String label;
  final Color background;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
