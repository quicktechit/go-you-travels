class OfficeAgentTeamMember {
  final String id;
  final String name;
  final String designation;
  final String empId;
  final String location;
  final double rating;
  final int totalRatings;
  final double? myRating;
  final String? myReviewNote;
  final List<String> selectedTags;
  final bool isOnDuty;

  const OfficeAgentTeamMember({
    required this.id,
    required this.name,
    required this.designation,
    required this.empId,
    required this.location,
    required this.rating,
    required this.totalRatings,
    this.myRating,
    this.myReviewNote,
    this.selectedTags = const [],
    this.isOnDuty = true,
  });

  OfficeAgentTeamMember copyWith({
    String? id,
    String? name,
    String? designation,
    String? empId,
    String? location,
    double? rating,
    int? totalRatings,
    double? myRating,
    String? myReviewNote,
    List<String>? selectedTags,
    bool? isOnDuty,
  }) {
    return OfficeAgentTeamMember(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      empId: empId ?? this.empId,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      totalRatings: totalRatings ?? this.totalRatings,
      myRating: myRating ?? this.myRating,
      myReviewNote: myReviewNote ?? this.myReviewNote,
      selectedTags: selectedTags ?? this.selectedTags,
      isOnDuty: isOnDuty ?? this.isOnDuty,
    );
  }
}
