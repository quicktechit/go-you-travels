import '../../../../core/constant/const.dart';
import '../model/team_member_model.dart';

final officeAgentTeamProvider = StateNotifierProvider<
    OfficeAgentTeamNotifier, List<OfficeAgentTeamMember>>((ref) {
  return OfficeAgentTeamNotifier();
});

class OfficeAgentTeamNotifier
    extends StateNotifier<List<OfficeAgentTeamMember>> {
  OfficeAgentTeamNotifier()
      : super([
          const OfficeAgentTeamMember(
            id: '1',
            name: 'Tanvir Ahmed',
            designation: 'Sr. Visa Processing Officer',
            empId: 'GYT-EMP-4082',
            location: 'Corporate HQ (Banani)',
            rating: 4.90,
            totalRatings: 28,
            myRating: null,
            isOnDuty: true,
          ),
          const OfficeAgentTeamMember(
            id: '2',
            name: 'Sharmin Akter',
            designation: 'Immigration Counselor',
            empId: 'GYT-EMP-4085',
            location: 'Corporate HQ (Banani)',
            rating: 4.85,
            totalRatings: 19,
            myRating: 5.0,
            myReviewNote: 'Incredible guidance on UKVI visa documentation!',
            selectedTags: ['Expert Counseling', 'Punctual'],
            isOnDuty: true,
          ),
          const OfficeAgentTeamMember(
            id: '3',
            name: 'Farhan Chowdhury',
            designation: 'Doc Verification Officer',
            empId: 'GYT-EMP-4089',
            location: 'Uttara Branch',
            rating: 4.65,
            totalRatings: 14,
            myRating: null,
            isOnDuty: false,
          ),
          const OfficeAgentTeamMember(
            id: '4',
            name: 'Ayesha Siddiqua',
            designation: 'Client Relations Executive',
            empId: 'GYT-EMP-4093',
            location: 'Corporate HQ (Banani)',
            rating: 4.92,
            totalRatings: 31,
            myRating: 4.5,
            myReviewNote: 'Very polite and swift response to client queries.',
            selectedTags: ['Fast Processing', 'Great Communication'],
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
