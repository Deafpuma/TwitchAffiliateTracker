class StreamModel {
  final String streamId;
  final String title;
  final String game;
  final DateTime startTime;
  final int viewerCount;

  StreamModel({
    required this.streamId,
    required this.title,
    required this.game,
    required this.startTime,
    required this.viewerCount,
  });

  factory StreamModel.fromMap(Map<String, dynamic> data) {
    return StreamModel(
      streamId: data['streamId'] ?? '',
      title: data['title'] ?? '',
      game: data['game'] ?? '',
      startTime: DateTime.parse(data['startTime'] ?? DateTime.now().toIso8601String()),
      viewerCount: data['viewerCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'streamId': streamId,
      'title': title,
      'game': game,
      'startTime': startTime.toIso8601String(),
      'viewerCount': viewerCount,
    };
  }
}
