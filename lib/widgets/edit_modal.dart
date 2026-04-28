import 'package:flutter/material.dart';
import '../models/patient_models.dart';

class EditModal extends StatefulWidget {
  const EditModal({super.key, required this.patient, required this.onClose});

  final Patient patient;
  final VoidCallback onClose;

  @override
  State<EditModal> createState() => _EditModalState();
}

class _EditModalState extends State<EditModal> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String selectedAllergy = 'Selecione';
  String selectedMedicine = 'Selecione';
  String selectedCondition = 'Selecione';
  String selectedBloodType = 'Selecione';

  late List<String> selectedAllergies;
  late List<String> selectedMedicines;
  late List<String> selectedConditions;
  late List<String> selectedBloodTypes;

  final List<String> allAllergies = [
    'Ovo',
    'Dipirona',
    'Ibuprofeno',
    'Lactose',
  ];
  final List<String> allMedicines = ['Venlafaxina', 'Dipirona', 'Metformina'];
  final List<String> allConditions = ['Asma', 'Hipertensão', 'Diabetes'];
  final List<String> allBloodTypes = [
    'Tipo A+',
    'Tipo A-',
    'Tipo B+',
    'Tipo B-',
    'Tipo AB+',
    'Tipo AB-',
    'Tipo O+',
    'Tipo O-',
  ];

  @override
  void initState() {
    super.initState();
    selectedAllergies = List.from(widget.patient.allergens);
    selectedMedicines = List.from(widget.patient.medications);
    selectedConditions = List.from(widget.patient.conditions);
    selectedBloodTypes = [widget.patient.bloodType];
    selectedBloodType = widget.patient.bloodType;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 260),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () async {
          await _animationController.reverse();
          widget.onClose();
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              color: Colors.black.withOpacity(0.35 * _fadeAnimation.value),
              child: Align(
                alignment: Alignment.centerRight,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 420,
                      height: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 28,
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Perfil de Marcelo',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              InkWell(
                                onTap: () async {
                                  await _animationController.reverse();
                                  widget.onClose();
                                },
                                borderRadius: BorderRadius.circular(999),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 24,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          const Divider(
                            height: 1.5,
                            color: Color(0xFFC7CDD4),
                            endIndent: 14,
                          ),
                          const SizedBox(height: 22),
                          _buildDropdownField(
                            context,
                            'Adicione alergias',
                            selectedAllergy,
                            allAllergies,
                            (value) {
                              if (value != 'Selecione' &&
                                  !selectedAllergies.contains(value)) {
                                setState(() {
                                  selectedAllergy = value;
                                  selectedAllergies.add(value);
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Icon(
                                Icons.emergency,
                                color: const Color(0xFFBE123C),
                              ),
                              ...selectedAllergies.map(
                                (item) => InputChip(
                                  label: Text(
                                    item.toUpperCase(),
                                    style: TextStyle(
                                      color: const Color(0xFFBE123C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  backgroundColor: const Color(0xFFFEE2E0),
                                  side: BorderSide.none,
                                  deleteIcon: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                  ),
                                  onDeleted: () {
                                    setState(
                                      () => selectedAllergies.remove(item),
                                    );
                                  },
                                  deleteButtonTooltipMessage: "Remover",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildDropdownField(
                            context,
                            'Remédios de uso recorrente',
                            selectedMedicine,
                            allMedicines,
                            (value) {
                              if (value != 'Selecione' &&
                                  !selectedMedicines.contains(value)) {
                                setState(() {
                                  selectedMedicine = value;
                                  selectedMedicines.add(value);
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Icon(
                                Icons.medication,
                                color: const Color(0xFF0B69A6),
                              ),
                              ...selectedMedicines.map(
                                (item) => InputChip(
                                  label: Text(
                                    item.toUpperCase(),
                                    style: TextStyle(
                                      color: const Color(0xFF0B69A6),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  backgroundColor: const Color(0xFFE0F2FE),
                                  side: BorderSide.none,
                                  deleteIcon: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                  ),
                                  onDeleted: () {
                                    setState(
                                      () => selectedMedicines.remove(item),
                                    );
                                  },
                                  deleteButtonTooltipMessage: "Remover",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildDropdownField(
                            context,
                            'Condições Clínicas de Saúde',
                            selectedCondition,
                            allConditions,
                            (value) {
                              if (value != 'Selecione' &&
                                  !selectedConditions.contains(value)) {
                                setState(() {
                                  selectedCondition = value;
                                  selectedConditions.add(value);
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Icon(
                                Icons.coronavirus,
                                color: const Color(0xFFB45309),
                              ),
                              ...selectedConditions.map(
                                (item) => InputChip(
                                  label: Text(
                                    item.toUpperCase(),
                                    style: TextStyle(
                                      color: const Color(0xFFB45309),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  backgroundColor: const Color(0xFFFFE4B5),
                                  side: BorderSide.none,
                                  deleteIcon: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                  ),
                                  onDeleted: () {
                                    setState(
                                      () => selectedConditions.remove(item),
                                    );
                                  },
                                  deleteButtonTooltipMessage: "Remover",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildDropdownField(
                            context,
                            'Tipo sanguíneo',
                            selectedBloodType,
                            allBloodTypes,
                            (value) {
                              if (value != 'Selecione') {
                                setState(() {
                                  selectedBloodType = value;
                                  selectedBloodTypes = [value];
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          if (selectedBloodType != 'Selecione')
                            Row(
                              children: [
                                const Icon(
                                  Icons.bloodtype_rounded,
                                  color: Color(0xFFBE123C),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  selectedBloodType,
                                  style: const TextStyle(
                                    color: Color(0xFFBE123C),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              await _animationController.reverse();
                              widget.onClose();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF05A383),
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: const Text(
                              'Salvar alterações',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    String label,
    String value,
    List<String> options,
    ValueChanged<String> onChange,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 8),
        DropdownMenu<String>(
          initialSelection: value == 'Selecione' ? null : value,
          dropdownMenuEntries: options
              .map((option) => DropdownMenuEntry(value: option, label: option))
              .toList(),
          onSelected: (selected) {
            if (selected != null) onChange(selected);
          },
          trailingIcon: const Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF475569),
          ),
          menuStyle: const MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          hintText: value,
        ),
      ],
    );
  }
}
