import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../provider/visa_file_provider.dart';
import '../widgets/visa_file_card_item.dart';
import '../widgets/visa_file_filter_chips.dart';

class QuickTechVisaFilesPage extends HookConsumerWidget {
  const QuickTechVisaFilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechVisaFilesProvider);
    final notifier = ref.read(quickTechVisaFilesProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final searchController = useTextEditingController(text: state.searchQuery);




    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Visa Files',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar
              AppTextField(
                controller: searchController,
                hint: 'Search by File ID, client name, or country...',
                prefixIcon: LucideIcons.search,
                suffixIcon: searchController.text.isNotEmpty ? LucideIcons.x : null,
                onChanged: (val) => notifier.setSearchQuery(val),
                borderRadius: 14,
              ),
              SizedBox(height: 16.h),

              // 2. Horizontal Category Filter Chips
              const VisaFileFilterChips(),
              SizedBox(height: 16.h),

              // 3. Visa File Cards List
              if (state.filteredFiles.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 48.h),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.folderSearch,
                        size: 42.sp,
                        color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No visa files found matching criteria',
                        style: GoogleFonts.figtree(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredFiles.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredFiles[index];
                    return VisaFileCardItem(visaFile: item);
                  },
                ),

              60.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
