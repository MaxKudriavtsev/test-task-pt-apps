class CatFact {
  final String fact;

  CatFact({required this.fact});

  factory CatFact.fromJson(Map<String, dynamic> json) {
    return CatFact(
      fact: json['fact'] ?? '',
    );
  }
}
