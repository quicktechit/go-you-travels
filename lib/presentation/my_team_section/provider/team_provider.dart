import 'package:go_you_travels/core/constant/const.dart';
import 'package:go_you_travels/presentation/my_team_section/model/team_member_model.dart';

final teamProvider = StateNotifierProvider<TeamNotifier, List<TeamMember>>((ref) {
  return TeamNotifier();
});

final officeTeamProvider = Provider<List<TeamMember>>((ref) {
  final list = ref.watch(teamProvider);
  return list.where((m) => m.agentType == TeamAgentType.office).toList();
});

final paidTeamProvider = Provider<List<TeamMember>>((ref) {
  final list = ref.watch(teamProvider);
  return list.where((m) => m.agentType == TeamAgentType.paid).toList();
});

final localTeamProvider = Provider<List<TeamMember>>((ref) {
  final list = ref.watch(teamProvider);
  return list.where((m) => m.agentType == TeamAgentType.local).toList();
});

class TeamNotifier extends StateNotifier<List<TeamMember>> {
  TeamNotifier()
      : super([
          // Office Agent Team Members
          const TeamMember(
            id: 'off_1',
            name: 'Tanvir Ahmed',
            designation: 'Sr. Visa Processing Officer',
            empId: 'GYT-EMP-4082',
            location: 'Corporate HQ (Banani)',
            rating: 4.90,
            totalRatings: 28,
            myRating: null,
            likes: 28,
            dislikes: 1,
            myReaction: UserReaction.none,
            isOnDuty: true,
            agentType: TeamAgentType.office,
          ),
          const TeamMember(
            id: 'off_2',
            name: 'Sharmin Akter',
            designation: 'Immigration Counselor',
            empId: 'GYT-EMP-4085',
            location: 'Corporate HQ (Banani)',
            rating: 4.85,
            totalRatings: 19,
            myRating: 5.0,
            likes: 42,
            dislikes: 2,
            myReaction: UserReaction.like,
            isOnDuty: true,
            agentType: TeamAgentType.office,
          ),
          const TeamMember(
            id: 'off_3',
            name: 'Farhan Chowdhury',
            designation: 'Doc Verification Officer',
            empId: 'GYT-EMP-4089',
            location: 'Uttara Branch',
            rating: 4.65,
            totalRatings: 14,
            myRating: null,
            likes: 15,
            dislikes: 3,
            myReaction: UserReaction.none,
            isOnDuty: false,
            agentType: TeamAgentType.office,
          ),
          const TeamMember(
            id: 'off_4',
            name: 'Ayesha Siddiqua',
            designation: 'Client Relations Executive',
            empId: 'GYT-EMP-4093',
            location: 'Corporate HQ (Banani)',
            rating: 4.92,
            totalRatings: 31,
            myRating: 4.5,
            likes: 56,
            dislikes: 1,
            myReaction: UserReaction.like,
            isOnDuty: true,
            agentType: TeamAgentType.office,
          ),

          // Paid Agent Team Members
          const TeamMember(
            id: 'paid_1',
            name: 'Shakil Hossain',
            designation: 'Sr. Paid Ads Specialist',
            empId: 'GYT-PA-5015',
            location: 'Banani HQ',
            rating: 4.85,
            totalRatings: 18,
            myRating: null,
            likes: 24,
            dislikes: 2,
            myReaction: UserReaction.none,
            isOnDuty: true,
            agentType: TeamAgentType.paid,
          ),
          const TeamMember(
            id: 'paid_2',
            name: 'Nusrat Jahan',
            designation: 'FB & Google Campaign Mgr',
            empId: 'GYT-PA-5019',
            location: 'Digital Ops HQ',
            rating: 4.92,
            totalRatings: 24,
            myRating: 5.0,
            likes: 38,
            dislikes: 0,
            myReaction: UserReaction.like,
            isOnDuty: true,
            agentType: TeamAgentType.paid,
          ),
          const TeamMember(
            id: 'paid_3',
            name: 'Mahmud Hasan',
            designation: 'Digital Lead Analyst',
            empId: 'GYT-PA-5022',
            location: 'Campaign Strategy',
            rating: 4.70,
            totalRatings: 12,
            myRating: null,
            likes: 18,
            dislikes: 4,
            myReaction: UserReaction.none,
            isOnDuty: false,
            agentType: TeamAgentType.paid,
          ),
          const TeamMember(
            id: 'paid_4',
            name: 'Sabrina Khan',
            designation: 'Social Media Growth Agent',
            empId: 'GYT-PA-5025',
            location: 'Banani HQ',
            rating: 4.88,
            totalRatings: 20,
            myRating: 4.5,
            likes: 31,
            dislikes: 1,
            myReaction: UserReaction.like,
            isOnDuty: true,
            agentType: TeamAgentType.paid,
          ),

          // Local Agent Team Members
          const TeamMember(
            id: 'loc_1',
            name: 'Rafiqul Islam',
            designation: 'Chittagong Regional Partner',
            empId: 'GYT-PRT-2811',
            location: 'Chittagong Hub (GEC)',
            rating: 4.88,
            totalRatings: 17,
            myRating: null,
            likes: 29,
            dislikes: 2,
            myReaction: UserReaction.none,
            isOnDuty: true,
            agentType: TeamAgentType.local,
          ),
          const TeamMember(
            id: 'loc_2',
            name: 'Jasim Uddin',
            designation: 'Sylhet District Lead',
            empId: 'GYT-PRT-2815',
            location: 'Sylhet Hub (Chowhatta)',
            rating: 4.95,
            totalRatings: 24,
            myRating: 5.0,
            likes: 47,
            dislikes: 1,
            myReaction: UserReaction.like,
            isOnDuty: true,
            agentType: TeamAgentType.local,
          ),
          const TeamMember(
            id: 'loc_3',
            name: 'Kawsar Ahmed',
            designation: 'Rajshahi Franchise Manager',
            empId: 'GYT-PRT-2822',
            location: 'Rajshahi Hub (Saheb Bazar)',
            rating: 4.68,
            totalRatings: 11,
            myRating: null,
            likes: 14,
            dislikes: 5,
            myReaction: UserReaction.none,
            isOnDuty: false,
            agentType: TeamAgentType.local,
          ),
          const TeamMember(
            id: 'loc_4',
            name: 'Fatema Tuz Zohra',
            designation: 'Khulna Field Agent Lead',
            empId: 'GYT-PRT-2826',
            location: 'Khulna Hub (KDA Avenue)',
            rating: 4.90,
            totalRatings: 20,
            myRating: 4.5,
            likes: 33,
            dislikes: 0,
            myReaction: UserReaction.like,
            isOnDuty: true,
            agentType: TeamAgentType.local,
          ),
        ]);

  void submitRating({
    required String memberId,
    required double rating,
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
        );
      }
      return member;
    }).toList();

    final member = state.firstWhere((m) => m.id == memberId);
    Fluttertoast.showToast(
      msg: "Rated ${rating.toStringAsFixed(1)} ★ for ${member.name}",
    );
  }

  void toggleReaction(String memberId, UserReaction reaction) {
    state = state.map((member) {
      if (member.id == memberId) {
        int newLikes = member.likes;
        int newDislikes = member.dislikes;
        UserReaction newReaction = reaction;

        if (member.myReaction == reaction) {
          // Toggle off reaction if clicked same button
          newReaction = UserReaction.none;
          if (reaction == UserReaction.like) newLikes = (newLikes > 0) ? newLikes - 1 : 0;
          if (reaction == UserReaction.dislike) newDislikes = (newDislikes > 0) ? newDislikes - 1 : 0;
        } else {
          // Switching reaction
          if (member.myReaction == UserReaction.dislike) {
            newDislikes = (newDislikes > 0) ? newDislikes - 1 : 0;
          }
          if (member.myReaction == UserReaction.like) {
            newLikes = (newLikes > 0) ? newLikes - 1 : 0;
          }

          if (reaction == UserReaction.like) newLikes++;
          if (reaction == UserReaction.dislike) newDislikes++;
        }

        return member.copyWith(
          likes: newLikes,
          dislikes: newDislikes,
          myReaction: newReaction,
        );
      }
      return member;
    }).toList();

    final member = state.firstWhere((m) => m.id == memberId);
    if (member.myReaction == UserReaction.like) {
      Fluttertoast.showToast(msg: "You liked ${member.name}");
    } else if (member.myReaction == UserReaction.dislike) {
      Fluttertoast.showToast(msg: "You disliked ${member.name}");
    } else {
      Fluttertoast.showToast(msg: "Reaction removed for ${member.name}");
    }
  }
}
