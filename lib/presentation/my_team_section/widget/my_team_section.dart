import '../../../../core/constant/const.dart';
import '../model/team_member_model.dart';
import '../provider/team_provider.dart';

class MyTeamSection extends ConsumerStatefulWidget {
  final TeamAgentType? initialAgentType;

  const MyTeamSection({
    super.key,
    this.initialAgentType,
  });

  @override
  ConsumerState<MyTeamSection> createState() => _MyTeamSectionState();
}

class _MyTeamSectionState extends ConsumerState<MyTeamSection> {
  late TeamAgentType? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialAgentType;
  }

  Color _getAccentColor(TeamAgentType? type) {
    switch (type) {
      case TeamAgentType.office:
        return AppColors.primary;
      case TeamAgentType.paid:
        return AppColors.yellow;
      case TeamAgentType.local:
        return AppColors.secondary;
      case null:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allTeam = ref.watch(teamProvider);

    final filteredList = _selectedType == null
        ? allTeam
        : allTeam.where((m) => m.agentType == _selectedType).toList();

    final accentColor = _getAccentColor(_selectedType);

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
                  color: accentColor,
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
                    ? accentColor.withValues(alpha: 0.2)
                    : accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.5),
                  width: 1.w,
                ),
              ),
              child: Text(
                '${filteredList.length} Members',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      fontSize: 11.sp,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          _selectedType == TeamAgentType.office
              ? 'Rate, like or dislike office colleagues to support collaboration'
              : _selectedType == TeamAgentType.paid
                  ? 'Rate, like or dislike campaign team members to boost performance'
                  : _selectedType == TeamAgentType.local
                      ? 'Rate, like or dislike regional hub partners to strengthen trust'
                      : 'Rate, like or dislike team members across Office, Paid, & Regional networks',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                fontSize: 11.5.sp,
              ),
        ),
        SizedBox(height: 12.h),

        // Filter Category Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildFilterChip(
                label: 'All (${allTeam.length})',
                isSelected: _selectedType == null,
                onTap: () => setState(() => _selectedType = null),
                accentColor: AppColors.primary,
                isDark: isDark,
              ),
              SizedBox(width: 8.w),
              _buildFilterChip(
                label: 'Office (${allTeam.where((m) => m.agentType == TeamAgentType.office).length})',
                isSelected: _selectedType == TeamAgentType.office,
                onTap: () => setState(() => _selectedType = TeamAgentType.office),
                accentColor: AppColors.primary,
                isDark: isDark,
              ),
              SizedBox(width: 8.w),
              _buildFilterChip(
                label: 'Paid Campaign (${allTeam.where((m) => m.agentType == TeamAgentType.paid).length})',
                isSelected: _selectedType == TeamAgentType.paid,
                onTap: () => setState(() => _selectedType = TeamAgentType.paid),
                accentColor: AppColors.yellow,
                isDark: isDark,
              ),
              SizedBox(width: 8.w),
              _buildFilterChip(
                label: 'Regional (${allTeam.where((m) => m.agentType == TeamAgentType.local).length})',
                isSelected: _selectedType == TeamAgentType.local,
                onTap: () => setState(() => _selectedType = TeamAgentType.local),
                accentColor: AppColors.secondary,
                isDark: isDark,
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),

        // Team List
        if (filteredList.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Text(
                'No team members found.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
                    ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final member = filteredList[index];
              return _buildTeamMemberCard(context, ref, member, isDark);
            },
          ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color accentColor,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor
              : isDark
                  ? AppColors.darkSurfaceHigh
                  : AppColors.line.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? accentColor : (isDark ? AppColors.darkLine : AppColors.line),
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? AppColors.surface
                    : isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                fontSize: 11.5.sp,
              ),
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(
    BuildContext context,
    WidgetRef ref,
    TeamMember member,
    bool isDark,
  ) {
    final accentColor = _getAccentColor(member.agentType);
    final initials = member.name.isNotEmpty
        ? member.name.split(' ').map((e) => e[0]).take(2).join()
        : 'TM';

    final isLiked = member.myReaction == UserReaction.like;
    final isDisliked = member.myReaction == UserReaction.dislike;

    final myRating = member.myRating ?? 0.0;

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
          // Top Info Row: Avatar + Details + Rating Pill
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with Duty Status Dot
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: accentColor.withValues(alpha: 0.18),
                    child: Text(
                      initials,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: accentColor,
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

              // Name, Agent Category & Designation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            member.name,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            member.agentType == TeamAgentType.office
                                ? 'Office'
                                : member.agentType == TeamAgentType.paid
                                    ? 'Paid'
                                    : 'Regional',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 9.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: accentColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      member.designation,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: accentColor,
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

              // Overall Average Rating Pill
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

          SizedBox(height: 12.h),

          // Simple Direct Interactive Star Rating Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurfaceHigh.withValues(alpha: 0.5)
                  : AppColors.background,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isDark
                    ? AppColors.darkLine
                    : AppColors.line.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  member.myRating != null
                      ? 'Your Rating: ${member.myRating!.toStringAsFixed(1)} ★'
                      : 'Rate Member:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                        color: member.myRating != null
                            ? accentColor
                            : (isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary),
                      ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    final starValue = (index + 1).toDouble();
                    final isSelected = myRating >= starValue;
                    return InkWell(
                      onTap: () {
                        ref.read(teamProvider.notifier).submitRating(
                              memberId: member.id,
                              rating: starValue,
                            );
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Icon(
                          LucideIcons.star,
                          size: 18.sp,
                          color: isSelected
                              ? (isDark ? AppColors.amber : AppColors.orange)
                              : (isDark ? AppColors.darkLine : AppColors.line),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),
          Divider(
            height: 1.h,
            color: isDark ? AppColors.darkLine : AppColors.line,
          ),
          SizedBox(height: 8.h),

          // Facebook Style Like & Dislike Action Buttons
          Row(
            children: [
              // Like Button
              Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(teamProvider.notifier).toggleReaction(
                          member.id,
                          UserReaction.like,
                        );
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isLiked
                          ? (isDark
                              ? AppColors.primaryDark.withValues(alpha: 0.4)
                              : AppColors.primaryLight.withValues(alpha: 0.2))
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: isLiked
                          ? Border.all(color: AppColors.primary, width: 1.w)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.thumbsUp,
                          size: 16.sp,
                          color: isLiked
                              ? AppColors.primary
                              : isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          isLiked ? 'Liked (${member.likes})' : 'Like (${member.likes})',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: isLiked ? FontWeight.bold : FontWeight.w600,
                                fontSize: 12.sp,
                                color: isLiked
                                    ? AppColors.primary
                                    : isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Dislike Button
              Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(teamProvider.notifier).toggleReaction(
                          member.id,
                          UserReaction.dislike,
                        );
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isDisliked
                          ? (isDark
                              ? AppColors.red.withValues(alpha: 0.2)
                              : AppColors.red.withValues(alpha: 0.1))
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: isDisliked
                          ? Border.all(color: AppColors.red, width: 1.w)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.thumbsDown,
                          size: 16.sp,
                          color: isDisliked
                              ? AppColors.red
                              : isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          isDisliked ? 'Disliked (${member.dislikes})' : 'Dislike (${member.dislikes})',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: isDisliked ? FontWeight.bold : FontWeight.w600,
                                fontSize: 12.sp,
                                color: isDisliked
                                    ? AppColors.red
                                    : isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
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
