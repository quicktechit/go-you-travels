import 'package:flutter/foundation.dart';

enum TeamAgentType {
  office('Office Consultants'),
  paid('Paid Campaign Team'),
  local('Regional Partners');

  final String label;
  const TeamAgentType(this.label);
}

enum UserReaction { none, like, dislike }

@immutable
class TeamMember {
  final String id;
  final String name;
  final String designation;
  final String empId;
  final String location;
  final double rating;
  final int totalRatings;
  final double? myRating;
  final int likes;
  final int dislikes;
  final UserReaction myReaction;
  final bool isOnDuty;
  final TeamAgentType agentType;

  const TeamMember({
    required this.id,
    required this.name,
    required this.designation,
    required this.empId,
    required this.location,
    required this.rating,
    required this.totalRatings,
    this.myRating,
    required this.likes,
    required this.dislikes,
    this.myReaction = UserReaction.none,
    this.isOnDuty = true,
    required this.agentType,
  });

  TeamMember copyWith({
    String? id,
    String? name,
    String? designation,
    String? empId,
    String? location,
    double? rating,
    int? totalRatings,
    double? myRating,
    int? likes,
    int? dislikes,
    UserReaction? myReaction,
    bool? isOnDuty,
    TeamAgentType? agentType,
  }) {
    return TeamMember(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      empId: empId ?? this.empId,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      myRating: myRating ?? this.myRating,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      myReaction: myReaction ?? this.myReaction,
      isOnDuty: isOnDuty ?? this.isOnDuty,
      agentType: agentType ?? this.agentType,
    );
  }
}
