import '../../../../core/constant/const.dart';
import '../model/local_agent_team_model.dart';

final localAgentTeamProvider = StateNotifierProvider<
    LocalAgentTeamNotifier, List<LocalAgentTeamMember>>((ref) {
  return LocalAgentTeamNotifier();
});

class LocalAgentTeamNotifier
    extends StateNotifier<List<LocalAgentTeamMember>> {
  LocalAgentTeamNotifier()
      : super([
          const LocalAgentTeamMember(
            id: '1',
            name: 'Rafiqul Islam',
            designation: 'Chittagong Regional Partner',
            partnerId: 'GYT-PRT-2811',
            hubLocation: 'Chittagong Hub (GEC)',
            rating: 4.88,
            totalRatings: 17,
            myRating: null,
            isOnDuty: true,
          ),
          const LocalAgentTeamMember(
            id: '2',
            name: 'Jasim Uddin',
            designation: 'Sylhet District Lead',
            partnerId: 'GYT-PRT-2815',
            hubLocation: 'Sylhet Hub (Chowhatta)',
            rating: 4.95,
            totalRatings: 24,
            myRating: 5.0,
            myReviewNote: 'Excellent local support and client referral management!',
            selectedTags: ['Great Client Support', 'Trustworthy'],
            isOnDuty: true,
          ),
          const LocalAgentTeamMember(
            id: '3',
            name: 'Kawsar Ahmed',
            designation: 'Rajshahi Franchise Manager',
            partnerId: 'GYT-PRT-2822',
            hubLocation: 'Rajshahi Hub (Saheb Bazar)',
            rating: 4.68,
            totalRatings: 11,
            myRating: null,
            isOnDuty: false,
          ),
          const LocalAgentTeamMember(
            id: '4',
            name: 'Fatema Tuz Zohra',
            designation: 'Khulna Field Agent Lead',
            partnerId: 'GYT-PRT-2826',
            hubLocation: 'Khulna Hub (KDA Avenue)',
            rating: 4.90,
            totalRatings: 20,
            myRating: 4.5,
            myReviewNote: 'Very quick on-ground document collection and support.',
            selectedTags: ['Prompt Referral', 'Regional Leadership'],
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
