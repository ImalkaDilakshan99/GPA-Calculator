import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/theme/theme.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/view/pages/custom_scale_editor_view.dart';
import 'package:gpa_calculator/viewModels/grading_scale_view_model.dart';

class GradingScaleManagementView extends ConsumerStatefulWidget {
  const GradingScaleManagementView({super.key});

  @override
  ConsumerState<GradingScaleManagementView> createState() =>
      _GradingScaleManagementViewState();
}

class _GradingScaleManagementViewState
    extends ConsumerState<GradingScaleManagementView> {
  final TextEditingController _searchController = TextEditingController();

  static const List<Map<String, String>> _categories = [
    {'id': 'all', 'label': 'All Scales'},
    {'id': 'recommended', 'label': 'Recommended'},
    {'id': 'international', 'label': 'International'},
    {'id': 'country', 'label': 'Country-Based'},
    {'id': 'university', 'label': 'University'},
    {'id': 'custom', 'label': 'Custom'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeScale = ref.watch(activeGradingScaleProvider);
    final filteredScalesAsync = ref.watch(filteredGradingScalesProvider);
    final selectedCategory = ref.watch(gradingScaleCategoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F111E),
      appBar: AppBar(
        title: const Text(
          'GPA Grading Scales',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF0F111E),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Create Custom Scale',
            icon: const Icon(Icons.add_rounded, color: Color(0xFF3861FB), size: 28),
            onPressed: () => _openCustomScaleEditor(context),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Active Grading Scale Banner ──────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: _buildActiveScaleHeader(activeScale),
            ),
          ),

          // ── Search Field ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF171A2B),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF22263C), width: 1),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by country, university, or scale (e.g. 4.0, India, HD)...',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF6F7D95),
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF3861FB),
                      size: 20,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, color: Color(0xFF8E9BAE), size: 18),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(gradingScaleSearchQueryProvider.notifier).setSearchQuery('');
                              setState(() {});
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  ),
                  onChanged: (val) {
                    ref.read(gradingScaleSearchQueryProvider.notifier).setSearchQuery(val);
                    setState(() {});
                  },
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // ── Category Filter Pills ────────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                separatorBuilder: (context, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat['id'] == selectedCategory;
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      ref.read(gradingScaleCategoryProvider.notifier).setCategory(cat['id']!);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF3861FB) : const Color(0xFF171A2B),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF3861FB) : const Color(0xFF22263C),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          cat['label']!,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF8E9BAE),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ── Scale List ───────────────────────────────────────────────
          filteredScalesAsync.when(
            data: (scales) {
              if (scales.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded, size: 48, color: Color(0xFF6F7D95)),
                          SizedBox(height: 12),
                          Text(
                            'No grading scales found.\nTry a different search or create a custom scale.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF8E9BAE),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final scale = scales[index];
                      final isActive = scale.id == activeScale.id;
                      return _buildScaleCard(context, scale, isActive);
                    },
                    childCount: scales.length,
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(color: Color(0xFF3861FB)),
                ),
              ),
            ),
            error: (err, stack) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent)),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF3861FB),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Create Custom Scale',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        onPressed: () => _openCustomScaleEditor(context),
      ),
    );
  }

  /// Prominent card showing currently active scale
  Widget _buildActiveScaleHeader(GradingScaleEntity activeScale) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2648), Color(0xFF141930)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF3861FB).withValues(alpha: 0.5), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x333861FB),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3861FB).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF3861FB), width: 1),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF3861FB)),
                    SizedBox(width: 4),
                    Text(
                      'CURRENT ACTIVE SCALE',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3861FB),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                activeScale.isPredefined ? 'Predefined' : 'Custom',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Color(0xFF8E9BAE),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            activeScale.name,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (activeScale.country != null && activeScale.country!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.public_rounded, size: 14, color: Color(0xFF8E9BAE)),
                const SizedBox(width: 4),
                Text(
                  activeScale.country!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: Color(0xFF8E9BAE),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              _metricPill('Max GPA', activeScale.maximumGpa.toStringAsFixed(1)),
              const SizedBox(width: 10),
              _metricPill('Grades', '${activeScale.entries.length} entries'),
              const SizedBox(width: 10),
              _metricPill('Direction', activeScale.isHigherBetter ? 'Higher is best' : 'Inverted (1.0 best)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricPill(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F111E).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF262B42), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              color: Color(0xFF6F7D95),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Scale item card
  Widget _buildScaleCard(BuildContext context, GradingScaleEntity scale, bool isActive) {
    final entryPreview = scale.entries.take(4).map((e) => '${e.grade} (${e.gradePoint.toStringAsFixed(1)})').join(' • ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFF171A2B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isActive ? const Color(0xFF3861FB) : const Color(0xFF22263C),
              width: isActive ? 2 : 1,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              if (!isActive) {
                _showScaleSelectionConfirmDialog(context, scale);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    scale.name,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (scale.country != null) ...[
                                  Text(
                                    scale.country!,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      color: Color(0xFF8E9BAE),
                                    ),
                                  ),
                                  const Text(' • ', style: TextStyle(color: Color(0xFF6F7D95))),
                                ],
                                Text(
                                  'Max ${scale.maximumGpa.toStringAsFixed(1)}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3861FB),
                                  ),
                                ),
                                if (!scale.isHigherBetter) ...[
                                  const Text(' • ', style: TextStyle(color: Color(0xFF6F7D95))),
                                  const Text(
                                    'Inverted',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 11,
                                      color: Color(0xFFFF9800),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3861FB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, size: 14, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'Active',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (scale.isCustom)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF8E9BAE)),
                              tooltip: 'Edit Custom Scale',
                              onPressed: () => _openCustomScaleEditor(context, scale: scale),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                              tooltip: 'Delete Custom Scale',
                              onPressed: () => _confirmDeleteCustomScale(context, scale),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (scale.description != null && scale.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      scale.description!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF8E9BAE),
                      ),
                    ),
                  ],
                  if (entryPreview.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F111E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        entryPreview + (scale.entries.length > 4 ? ' • ...' : ''),
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: Color(0xFF6F7D95),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dialog when selecting a new grading scale (offers safe choice: future only vs recalculate existing)
  void _showScaleSelectionConfirmDialog(BuildContext context, GradingScaleEntity targetScale) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF171A2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFF262B42), width: 1),
          ),
          title: Text(
            'Select "${targetScale.name}"?',
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You are changing your active grading scale to ${targetScale.name} (Max ${targetScale.maximumGpa.toStringAsFixed(1)}).\n\nHow would you like to handle your existing semester subjects?',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF8E9BAE),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F111E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF262B42)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Apply to Future Subjects (Recommended)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFF3861FB),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Leaves historical subject grade points untouched, avoiding changes to past semester results.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFF8E9BAE),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '• Recalculate Existing Subjects',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFFFF9800),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Remaps matching letter grades on existing subjects to the new scale points.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFF8E9BAE),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF3861FB),
                          side: const BorderSide(color: Color(0xFF3861FB), width: 1.4),
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          Navigator.of(dialogContext).pop();
                          await setActiveGradingScale(ref, targetScale.id, recalculateExisting: false);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Switched to ${targetScale.name} (Future subjects only)')),
                            );
                          }
                        },
                        child: const Text('Future Only', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3861FB),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          Navigator.of(dialogContext).pop();
                          await setActiveGradingScale(ref, targetScale.id, recalculateExisting: true);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Switched to ${targetScale.name} and recalculated records')),
                            );
                          }
                        },
                        child: const Text('Recalculate All', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF8E9BAE),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ],

        );
      },
    );
  }

  void _confirmDeleteCustomScale(BuildContext context, GradingScaleEntity scale) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF171A2B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Delete Custom Scale?', style: TextStyle(color: Colors.white)),
          content: Text(
            'Are you sure you want to delete "${scale.name}"? This cannot be undone.',
            style: const TextStyle(color: Color(0xFF8E9BAE)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF8E9BAE))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                try {
                  await deleteCustomGradingScale(ref, scale.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Custom scale deleted')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cannot delete scale: $e')),
                    );
                  }
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _openCustomScaleEditor(BuildContext context, {GradingScaleEntity? scale}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomScaleEditorView(scaleToEdit: scale),
      ),
    );
  }
}
