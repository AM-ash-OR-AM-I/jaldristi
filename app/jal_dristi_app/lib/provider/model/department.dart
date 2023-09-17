class Department {
  final String name;
  final int id;
  final String description;

  Department({
    required this.name,
    required this.id,
    this.description = "",
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
