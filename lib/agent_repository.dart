class Agent{
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final String fullPortrait;
  final String role;

  Agent({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.fullPortrait,
    required this.role,
});

  Map<String, dynamic> toMap() {
  return {
    "id": id,
    "name": name,
    "description": description,
    "iconUrl": iconUrl,
    "fullPortrait": fullPortrait,
    "role": role,
  };
  }
  factory Agent.fromMap(Map<dynamic, dynamic> map) {
    return Agent(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      description: map["description"] ?? "",
      iconUrl: map["iconUrl"] ?? "",
      fullPortrait: map["fullPortrait"] ?? "",
      role: map["role"] ?? "Brak roli",
    );
  }
}