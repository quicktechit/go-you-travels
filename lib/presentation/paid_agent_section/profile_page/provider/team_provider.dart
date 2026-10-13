import '../../../../core/constant/const.dart';
import '../model/team_member_model.dart';

final paidAgentTeamProvider = StateNotifierProvider<
    PaidAgentTeamNotifier, List<PaidAgentTeamMember>>((ref) {
  return PaidAgentTeamNotifier();
});

class PaidAgentTeamNotifier extends StateNotifier<List<PaidAgentTeamMember>> {
  PaidAgentTeamNotifier()
      : super([
          const PaidAgentTeamMember(
            id: '1',
            name: 'Shakil Hossain',
            designation: 'Sr. Paid Ads Specialist',
            empId: 'GYT-PA-5015',
            location: 'Banani HQ',
            rating: 4.85,
            totalRatings: 18,
            myRating: null,
            isOnDuty: true,
          ),
          const PaidAgentTeamMember(
            id: '2',
            name: 'Nusrat Jahan',
            designation: 'FB & Google Campaign Mgr',
            empId: 'GYT-PA-5019',
            location: 'Digital Ops HQ',
            rating: 4.92,
            totalRatings: 24,
            myRating: 5.0,
            myReviewNote: 'Outstanding campaign performance and ROI optimization!',
            selectedTags: ['High Conversion', 'Fast Response'],
            isOnDuty: true,
          ),
          const PaidAgentTeamMember(
            id: '3',
            name: 'Mahmud Hasan',
            designation: 'Digital Lead Analyst',
            empId: 'GYT-PA-5022',
            location: 'Campaign Strategy',
            rating: 4.70,
            totalRatings: 12,
            myRating: null,
            isOnDuty: false,
          ),
          const PaidAgentTeamMember(
            id: '4',
            name: 'Sabrina Khan',
            designation: 'Social Media Growth Agent',
            empId: 'GYT-PA-5025',
            location: 'Banani HQ',
            rating: 4.88,
            totalRatings: 20,
            myRating: 4.5,
            myReviewNote: 'Great targeting and lead generation consistency.',
            selectedTags: ['Great Ads Optimization', 'Team Player'],
            isOnDuty: true,
          ),
        ]);

  void submitRating({
    required String memberId,
    required double rating,
    String? reviewNote,
    List<String>? tags,
  }) {
    state = state.map((member) {
      if (member.id == memberId) {
        final isFirstRating = member.myRating == null;
        final newTotalRatings =
            isFirstRating ? member.totalRatings + 1 : member.totalRatings;

        // Calculate updated average rating
        final previousSum = member.rating * member.totalRatings;
        final adjustedSum = isFirstRating
            ? (previousSum + rating)
            : (previousSum - (member.myRating ?? 0) + rating);
        final newAvgRating = double.parse(
            (adjustedSum / newTotalRatings).toStringAsFixed(2));

        return member.copyWith(
          myRating: rating,
          rating: newAvgRating,
          totalRatings: newTotalRatings,
          myReviewNote: reviewNote,
          selectedTags: tags ?? member.selectedTags,
        );
      }
      return member;
    }).toList();

    final member = state.firstWhere((m) => m.id == memberId);
    Fluttertoast.showToast(
      msg: "Rating of ${rating.toStringAsFixed(1)} ★ submitted for ${member.name}",
    );
  }
}
