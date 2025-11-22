class QuickMessage {
  final String id;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuickMessage({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  QuickMessage copyWith({
    String? id,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuickMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory QuickMessage.fromJson(Map<String, dynamic> json) {
    return QuickMessage(
      id: json['id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
