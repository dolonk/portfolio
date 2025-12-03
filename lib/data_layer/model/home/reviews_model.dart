class ReviewsModel {
  final String name;
  final String role;
  final int rating;
  final String imagePath;
  final String quote;

  ReviewsModel({
    required this.name,
    required this.role,
    required this.rating,
    required this.imagePath,
    required this.quote,
  });

  static List<ReviewsModel> getReviewsData() {
    return [
      ReviewsModel(
        name: "UJJOL KD",
        role: "Startup Founder of Dayzo",
        rating: 5,
        imagePath: "assets/home/icon/sul.png",
        quote:
            "Working with this team was a game changer. They delivered a fully functional iOS and Android app ahead of schedule with flawless performance. The communication was clear and responsive throughout the process.",
      ),
      ReviewsModel(
        name: "Mir Sultan",
        role: "Startup Founder of Space IT",
        rating: 5,
        imagePath: "assets/home/icon/sul.png",
        quote:
            "Working with this developer was a game changer. The communication was clear and responsive throughout the process. Highly recommended!",
      ),
    ];
  }
}
