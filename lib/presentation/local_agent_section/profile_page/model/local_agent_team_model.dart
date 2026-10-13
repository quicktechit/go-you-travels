class LocalAgentTeamMember {
  final String id;
  final String name;
  final String designation;
  final String partnerId;
  final String hubLocation;
  final double rating;
  final int totalRatings;
  final double? myRating;
  final String? myReviewNote;
  final List<String> selectedTags;
  final bool isOnDuty;

  const LocalAgentTeamMember({
    required this.id,
    required this.name,
    required this.designation,
    required this.partnerId,
    required this.hubLocation,
    required this.rating,
    required this.totalRatings,
    this.myRating,
    this.myReviewNote,
    this.selectedTags = const [],
    this.isOnDuty = true,
  });

  LocalAgentTeamMember copyWith({
    String? id,
    String? name,
    String? designation,
    String? partnerId,
    String? hubLocation,
    double? rating,
    int? totalRatings,
    double? myRating,
    String? myReviewNote,
    List<String>? selectedTags,
    bool? isOnDuty,
  }) {
    return LocalAgentTeamMember(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      partnerId: partnerId ?? this.partnerId,
      hubLocation: hubLocation ?? this.hubLocation,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      myRating: myRating ?? this.myRating,
      myReviewNote: myReviewNote ?? this.myReviewNote,
      selectedTags: selectedTags ?? this.selectedTags,
      isOnDuty: isOnDuty ?? this.isOnDuty,
    );
  }
}
