class CallCenterAgent {
  final String name;
  final String offer;
  final String enterprise;

  CallCenterAgent({
    required this.name,
    required this.offer,
    required this.enterprise,
  });

  factory CallCenterAgent.fromJson(Map<String, dynamic> json) {
    return CallCenterAgent(
      name: json['name'],
      offer: json['offer'],
      enterprise: json['enterprise'],
    );
  }
}
