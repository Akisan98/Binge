enum MediaStatus {
  planned,
  inProduction,
  postProduction,
  released,
  returningSeries,
  canceled,
  ended
}

extension MediaStatusExtension on MediaStatus {
  String get string {
    switch (this) {
      case MediaStatus.planned:
        return 'Planned';
      case MediaStatus.inProduction:
        return 'In Production';
      case MediaStatus.postProduction:
        return 'Post Production';
      case MediaStatus.released:
        return 'Released';
      case MediaStatus.returningSeries:
        return 'Returning Series';
      case MediaStatus.canceled:
        return 'Canceled';
      case MediaStatus.ended:
        return 'Ended';
    }
  }
}
