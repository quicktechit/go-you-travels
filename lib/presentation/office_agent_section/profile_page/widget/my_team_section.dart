import '../../../../core/constant/const.dart';
import '../model/team_member_model.dart';
import '../provider/team_provider.dart';

class MyTeamSection extends ConsumerWidget {
  const MyTeamSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(officeAgentTeamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.users,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
                SizedBox(width: 8.w),
                Text(
                  'MY TEAM',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primaryDark.withValues(alpha: 0.3)
                    : AppColors.primaryLight.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  width: 1.w,
                ),
              ),
              child: Text(
                '${teamList.length} Team Members',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                      fontSize: 11.sp,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Rate your office colleagues to improve counselor collaboration & visa service',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                fontSize: 11.5.sp,
              ),
        ),
        SizedBox(height: 12.h),

        // Team List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: teamList.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final member = teamList[index];
            return _buildTeamMemberCard(context, ref, member, isDark);
          },
        ),
      ],
    );
  }

  Widget _buildTeamMemberCard(
    BuildContext context,
    WidgetRef ref,
    OfficeAgentTeamMember member,
    bool isDark,
  ) {
    final initials = member.name.isNotEmpty
        ? member.name.split(' ').map((e) => e[0]).take(2).join()
        : 'OA';

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark
              ? AppColors.darkLine
              : AppColors.darkTextSecondary.withAlpha(50),
          width: 1.w,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Info Row: Avatar + Details + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with Online Status
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    child: Text(
                      initials,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                          ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12.r,
                      height: 12.r,
                      decoration: BoxDecoration(
                        color: member.isOnDuty
                            ? AppColors.successGreen
                            : AppColors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).cardColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),

              // Name & Designation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      member.designation,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${member.empId} · ${member.location}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
              ),

              // Overall Rating Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceHigh
                      : AppColors.amber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '⭐',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '${member.rating}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.amber : AppColors.orange,
                          ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '(${member.totalRatings})',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // User's Given Rating & Button Row
          SizedBox(height: 12.h),
          Divider(
            height: 1.h,
            color: isDark ? AppColors.darkLine : AppColors.line,
          ),
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User rating status
              if (member.myRating != null)
                Row(
                  children: [
                    Icon(
                      LucideIcons.circleCheck,
                      size: 14.sp,
                      color: AppColors.successGreen,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Your Rating: ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.5.sp,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary,
                          ),
                    ),
                    Text(
                      '${member.myRating!.toStringAsFixed(1)} ★',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.5.sp,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Icon(
                      LucideIcons.star,
                      size: 14.sp,
                      color: isDark
                          ? AppColors.darkTextMuted
                          : AppColors.textMuted,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Not rated yet',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11.5.sp,
                            color: isDark
                                ? AppColors.darkTextMuted
                                : AppColors.textMuted,
                          ),
                    ),
                  ],
                ),

              // Give / Edit Rating Button
              InkWell(
                onTap: () => _showRatingModal(context, ref, member, isDark),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: member.myRating != null
                        ? (isDark
                            ? AppColors.primaryDark.withValues(alpha: 0.3)
                            : AppColors.blueLight)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        member.myRating != null
                            ? LucideIcons.pencil
                            : LucideIcons.star,
                        size: 13.sp,
                        color: member.myRating != null
                            ? AppColors.primary
                            : AppColors.surface,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        member.myRating != null
                            ? 'Update Rating'
                            : 'Give Rating',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5.sp,
                              color: member.myRating != null
                                  ? AppColors.primary
                                  : AppColors.surface,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /*
          // User's review note preview if available
          if (member.myReviewNote != null &&
              member.myReviewNote!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceHigh.withValues(alpha: 0.5)
                    : AppColors.background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '"${member.myReviewNote}"',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: 11.sp,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textMuted,
                    ),
              ),
            ),
          ],
          */
        ],
      ),
    );
  }

  void _showRatingModal(
    BuildContext context,
    WidgetRef ref,
    OfficeAgentTeamMember member,
    bool isDark,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _RatingBottomSheet(
          member: member,
          isDark: isDark,
          onSubmit: (selectedRating, note, tags) {
            ref.read(officeAgentTeamProvider.notifier).submitRating(
                  memberId: member.id,
                  rating: selectedRating,
                  reviewNote: note,
                  tags: tags,
                );
          },
        );
      },
    );
  }
}

class _RatingBottomSheet extends StatefulHookWidget {
  final OfficeAgentTeamMember member;
  final bool isDark;
  final void Function(
      double selectedRating, String? note, List<String> tags) onSubmit;

  const _RatingBottomSheet({
    required this.member,
    required this.isDark,
    required this.onSubmit,
  });

  @override
  State<_RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<_RatingBottomSheet> {
  late double _currentRating;
  late TextEditingController _noteController;
  late List<String> _selectedTags;

  final List<String> _availableTags = [
    'Expert Counseling',
    'Fast Processing',
    'Great Communication',
    'Punctual',
    'Team Player',
  ];

  @override
  void initState() {
    super.initState();
    _currentRating = widget.member.myRating ?? 5.0;
    _noteController =
        TextEditingController(text: widget.member.myReviewNote ?? '');
    _selectedTags = List.from(widget.member.selectedTags);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bottomsheet handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? AppColors.darkLine
                        : AppColors.line,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Title Header
              Text(
                'Rate Office Team Member',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Give counselor & officer feedback for ${widget.member.name}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: widget.isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: 16.h),

              // Member Card Banner
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? AppColors.primaryDark.withValues(alpha: 0.3)
                      : AppColors.primaryLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        widget.member.name[0],
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.surface,
                            ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.member.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '${widget.member.designation} (${widget.member.empId})',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: widget.isDark
                                          ? AppColors.primaryLight
                                          : AppColors.primaryDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Interactive 5 Star Selector
              Center(
                child: Column(
                  children: [
                    Text(
                      '${_currentRating.toStringAsFixed(1)} / 5.0',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starValue = index + 1.0;
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              _currentRating = starValue;
                            });
                          },
                          icon: Icon(
                            index < _currentRating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 36.sp,
                            color: index < _currentRating
                                ? AppColors.yellow
                                : (widget.isDark
                                    ? AppColors.darkTextMuted
                                    : AppColors.textMuted),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              /*
              // Preset Compliment Tags
              Text(
                'Quick Feedback Tags',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: _availableTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    selectedColor: AppColors.primary,
                    checkmarkColor: AppColors.surface,
                    labelStyle: TextStyle(
                      fontSize: 11.sp,
                      color: isSelected
                          ? AppColors.surface
                          : (widget.isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.h),

              // Comment / Note Field
              Text(
                'Review Note (Optional)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _noteController,
                maxLines: 2,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  hintText:
                      'e.g. Excellent visa guidance, highly recommended officer...',
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: widget.isDark
                        ? AppColors.darkTextMuted
                        : AppColors.textMuted,
                  ),
                  contentPadding: EdgeInsets.all(12.r),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: widget.isDark
                          ? AppColors.darkLine
                          : AppColors.line,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              */
              SizedBox(height: 16.h),

              // Submit Button
              AppButton(
                onPressed: () {
                  widget.onSubmit(
                    _currentRating,
                    _noteController.text.trim(),
                    _selectedTags,
                  );
                  Navigator.pop(context);
                },
                text: 'Submit Rating',
                icon: LucideIcons.check,
                backgroundColor: AppColors.primary,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
