class ReviewEntity {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  ReviewEntity copyWith({
    int? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) => ReviewEntity(
    rating: rating ?? this.rating,
    comment: comment ?? this.comment,
    date: date ?? this.date,
    reviewerName: reviewerName ?? this.reviewerName,
    reviewerEmail: reviewerEmail ?? this.reviewerEmail,
  );
}
