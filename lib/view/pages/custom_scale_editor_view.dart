import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';
import 'package:gpa_calculator/viewModels/grading_scale_view_model.dart';

class CustomScaleEditorView extends ConsumerStatefulWidget {
  final GradingScaleEntity? scaleToEdit;

  const CustomScaleEditorView({super.key, this.scaleToEdit});

  bool get isEditing => scaleToEdit != null;

  @override
  ConsumerState<CustomScaleEditorView> createState() =>
      _CustomScaleEditorViewState();
}

class _CustomScaleEditorViewState extends ConsumerState<CustomScaleEditorView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _countryController;
  late final TextEditingController _universityController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _maxGpaController;
  late final TextEditingController _minValController;
  late final TextEditingController _passingValController;
  late final TextEditingController _decimalPlacesController;

  String _calculationType = 'gpa';
  bool _isHigherBetter = true;
  bool _isSaving = false;

  late List<GradingScaleEntryEntity> _entries;

  static const List<Map<String, String>> _scaleTypes = [
    {'id': 'gpa', 'label': 'GPA / Grade Points'},
    {'id': 'letter', 'label': 'Letter Grades'},
    {'id': 'numerical', 'label': 'Numerical Marks'},
    {'id': 'percentage', 'label': 'Percentage (%)'},
    {'id': 'inverted', 'label': 'Inverted Numerical Grades'},
    {'id': 'custom', 'label': 'Custom System'},
  ];

  @override
  void initState() {
    super.initState();
    final s = widget.scaleToEdit;
    _nameController = TextEditingController(text: s?.name ?? '');
    _countryController = TextEditingController(text: s?.country ?? '');
    _universityController = TextEditingController(text: s?.university ?? '');
    _descriptionController = TextEditingController(text: s?.description ?? '');
    _maxGpaController = TextEditingController(text: s != null ? s.maximumGpa.toString() : '4.0');
    _minValController = TextEditingController(text: s != null ? s.minimumValue.toString() : '0.0');
    _passingValController = TextEditingController(text: s != null ? s.passingValue.toString() : '2.0');
    _decimalPlacesController = TextEditingController(text: s != null ? s.decimalPlaces.toString() : '2');

    _calculationType = s?.calculationType ?? 'gpa';
    _isHigherBetter = s?.isHigherBetter ?? true;

    if (s != null && s.entries.isNotEmpty) {
      _entries = List.from(s.entries);
    } else {
      // Default starting template
      _entries = [
        const GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'A', gradePoint: 4.0, isPassing: true, displayOrder: 0),
        const GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'B', gradePoint: 3.0, isPassing: true, displayOrder: 1),
        const GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'C', gradePoint: 2.0, isPassing: true, displayOrder: 2),
        const GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'D', gradePoint: 1.0, isPassing: true, displayOrder: 3),
        const GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'F', gradePoint: 0.0, isPassing: false, displayOrder: 4),
      ];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _universityController.dispose();
    _descriptionController.dispose();
    _maxGpaController.dispose();
    _minValController.dispose();
    _passingValController.dispose();
    _decimalPlacesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111E),
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Custom Scale' : 'Create Custom Scale',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F111E),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveScale,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF3861FB)),
                  )
                : const Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF3861FB),
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Basic Information Section ──────────────────────────────
              const Text('Basic Information', style: AppTextStyles.titleMedium),
              const SizedBox(height: 10),
              Container(
                decoration: _cardBoxDecoration(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: _textStyleInput(),
                      decoration: _inputDecoration('Scale Name * (e.g. Harvard 4.0, Mumbai Univ 10)'),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Scale name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _countryController,
                      style: _textStyleInput(),
                      decoration: _inputDecoration('Country / Region (optional)'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _universityController,
                      style: _textStyleInput(),
                      decoration: _inputDecoration('University / Institution (optional)'),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _descriptionController,
                      style: _textStyleInput(),
                      maxLines: 2,
                      decoration: _inputDecoration('Description (optional)'),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: _calculationType,
                      dropdownColor: const Color(0xFF171A2B),
                      decoration: _inputDecoration('Scale Type'),
                      items: _scaleTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type['id'],
                          child: Text(type['label']!, style: const TextStyle(color: Colors.white, fontFamily: 'Inter')),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _calculationType = val;
                            if (val == 'inverted') {
                              _isHigherBetter = false;
                            } else if (val == 'gpa' || val == 'numerical' || val == 'percentage') {
                              _isHigherBetter = true;
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Scale Configuration ────────────────────────────────────
              const Text('Scale Configuration', style: AppTextStyles.titleMedium),
              const SizedBox(height: 10),
              Container(
                decoration: _cardBoxDecoration(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _maxGpaController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: _textStyleInput(),
                            decoration: _inputDecoration('Max Value * (e.g. 4.0)'),
                            validator: (val) {
                              if (val == null || double.tryParse(val) == null) {
                                return 'Enter valid max';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: TextFormField(
                            controller: _minValController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: _textStyleInput(),
                            decoration: _inputDecoration('Min Value (e.g. 0.0)'),
                            validator: (val) {
                              if (val == null || double.tryParse(val) == null) {
                                return 'Enter valid min';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _passingValController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: _textStyleInput(),
                            decoration: _inputDecoration('Passing Threshold (e.g. 2.0)'),
                            validator: (val) {
                              if (val == null || double.tryParse(val) == null) {
                                return 'Enter valid pass threshold';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: TextFormField(
                            controller: _decimalPlacesController,
                            keyboardType: TextInputType.number,
                            style: _textStyleInput(),
                            decoration: _inputDecoration('Decimal Places (e.g. 2)'),
                            validator: (val) {
                              final num = int.tryParse(val ?? '');
                              if (num == null || num < 0 || num > 4) {
                                return '0 - 4 places';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Higher Values are Better',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _isHigherBetter
                                  ? 'Standard scale (e.g. 4.0 or 10.0 is best)'
                                  : 'Inverted scale (e.g. German 1.0 is best, 5.0 is fail)',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF8E9BAE),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: _isHigherBetter,
                          activeThumbColor: const Color(0xFF3861FB),
                          onChanged: (val) {
                            setState(() => _isHigherBetter = val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Grade Mapping Table ────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Grade Mapping Table', style: AppTextStyles.titleMedium),
                  TextButton.icon(
                    icon: const Icon(Icons.add_rounded, size: 18, color: Color(0xFF3861FB)),
                    label: const Text(
                      'Add Grade',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3861FB),
                      ),
                    ),
                    onPressed: () => _showAddOrEditGradeDialog(),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                decoration: _cardBoxDecoration(),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // Table Header
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text('Grade', style: _headerStyle)),
                          Expanded(flex: 3, child: Text('Points', style: _headerStyle)),
                          Expanded(flex: 3, child: Text('Status', style: _headerStyle)),
                          SizedBox(width: 80, child: Text('Action', style: _headerStyle, textAlign: TextAlign.end)),
                        ],
                      ),
                    ),
                    const Divider(color: Color(0xFF22263C)),

                    if (_entries.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No grade entries. Tap "+ Add Grade" to add mapping entries.',
                          style: TextStyle(color: Color(0xFF8E9BAE), fontFamily: 'Inter'),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _entries.length,
                        separatorBuilder: (context, _) => const Divider(color: Color(0xFF1E2235), height: 1),
                        itemBuilder: (context, index) {
                          final e = _entries[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: e.isPassing ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          e.grade,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    e.gradePoint.toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    e.isPassing ? 'Pass' : 'Fail',
                                    style: TextStyle(
                                      color: e.isPassing ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        onTap: () => _showAddOrEditGradeDialog(indexToEdit: index),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(Icons.edit_outlined, size: 18, color: Color(0xFF8E9BAE)),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(6),
                                        onTap: () {
                                          setState(() => _entries.removeAt(index));
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3861FB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _isSaving ? null : _saveScale,
                  child: _isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.isEditing ? 'Save Changes' : 'Create Grading Scale',
                          style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddOrEditGradeDialog({int? indexToEdit}) {
    final isEditing = indexToEdit != null;
    final existing = isEditing ? _entries[indexToEdit] : null;

    final gradeLabelController = TextEditingController(text: existing?.grade ?? '');
    final gradePointController = TextEditingController(text: existing != null ? existing.gradePoint.toString() : '');
    bool isPassing = existing?.isPassing ?? true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF171A2B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFF262B42)),
              ),
              title: Text(
                isEditing ? 'Edit Grade Entry' : 'Add Grade Entry',
                style: const TextStyle(color: Colors.white, fontFamily: 'Inter', fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: gradeLabelController,
                    style: _textStyleInput(),
                    decoration: _inputDecoration('Grade Label (e.g. A, HD, 1.0, 85%)'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: gradePointController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: _textStyleInput(),
                    decoration: _inputDecoration('Grade Point Value (e.g. 4.0)'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Is Passing Grade?', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
                      Switch(
                        value: isPassing,
                        activeThumbColor: const Color(0xFF10B981),
                        onChanged: (val) {
                          setDialogState(() => isPassing = val);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel', style: TextStyle(color: Color(0xFF8E9BAE))),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3861FB),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    final label = gradeLabelController.text.trim();
                    final point = double.tryParse(gradePointController.text.trim());

                    if (label.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a grade label')),
                      );
                      return;
                    }
                    if (point == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid numeric grade point')),
                      );
                      return;
                    }

                    // Check for duplicate labels (excluding current editing item)
                    for (int i = 0; i < _entries.length; i++) {
                      if (isEditing && i == indexToEdit) continue;
                      if (_entries[i].grade.trim().toUpperCase() == label.toUpperCase()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Grade "$label" already exists in this scale')),
                        );
                        return;
                      }
                    }

                    final newEntry = GradingScaleEntryEntity(
                      id: existing?.id ?? 0,
                      gradingScaleId: existing?.gradingScaleId ?? 0,
                      grade: label,
                      gradePoint: point,
                      isPassing: isPassing,
                      displayOrder: isEditing ? existing!.displayOrder : _entries.length,
                    );

                    setState(() {
                      if (isEditing) {
                        _entries[indexToEdit] = newEntry;
                      } else {
                        _entries.add(newEntry);
                      }
                    });

                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(isEditing ? 'Update' : 'Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveScale() async {
    if (!_formKey.currentState!.validate()) return;

    if (_entries.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least 2 grade mapping entries')),
      );
      return;
    }

    final maxGpa = double.parse(_maxGpaController.text.trim());
    final minVal = double.parse(_minValController.text.trim());
    final passingVal = double.parse(_passingValController.text.trim());
    final decimalPlaces = int.parse(_decimalPlacesController.text.trim());

    // Best/worst values:
    final bestVal = _isHigherBetter ? maxGpa : minVal;
    final worstVal = _isHigherBetter ? minVal : maxGpa;

    setState(() => _isSaving = true);

    try {
      final now = DateTime.now();
      final scaleEntity = GradingScaleEntity(
        id: widget.scaleToEdit?.id ?? 0,
        name: _nameController.text.trim(),
        country: _countryController.text.trim().isNotEmpty ? _countryController.text.trim() : null,
        university: _universityController.text.trim().isNotEmpty ? _universityController.text.trim() : null,
        description: _descriptionController.text.trim().isNotEmpty ? _descriptionController.text.trim() : null,
        maximumGpa: maxGpa,
        scaleType: ScaleType.custom,
        category: 'custom',
        calculationType: _calculationType,
        minimumValue: minVal,
        bestValue: bestVal,
        worstValue: worstVal,
        passingValue: passingVal,
        isHigherBetter: _isHigherBetter,
        decimalPlaces: decimalPlaces,
        isDefault: widget.scaleToEdit?.isDefault ?? false,
        entries: _entries,
        createdAt: widget.scaleToEdit?.createdAt ?? now,
        updatedAt: now,
      );

      if (widget.isEditing) {
        await updateCustomGradingScale(ref, scaleEntity);
      } else {
        await createCustomGradingScale(ref, scaleEntity);
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Custom scale "${scaleEntity.name}" saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving scale: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  BoxDecoration _cardBoxDecoration() {
    return BoxDecoration(
      color: const Color(0xFF171A2B),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF22263C), width: 1),
    );
  }

  TextStyle _textStyleInput() {
    return const TextStyle(fontFamily: 'Inter', color: Colors.white, fontSize: 14);
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontFamily: 'Inter', color: Color(0xFF8E9BAE), fontSize: 13),
      filled: true,
      fillColor: const Color(0xFF0F111E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF262B42)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF262B42)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3861FB), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  static const _headerStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(0xFF8E9BAE),
  );
}
