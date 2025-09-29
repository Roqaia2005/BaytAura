class ChatResponse {
  final String answer;
  final String sessionId;
  final String queryId;
  final DateTime timestamp;

  ChatResponse({
    required this.answer,
    required this.sessionId,
    required this.queryId,
    required this.timestamp,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      answer: json['answer'] ?? '',
      sessionId: json['session_id'] ?? '',
      queryId: json['query_id'] ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
    );
  }
}
