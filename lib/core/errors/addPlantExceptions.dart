class PlantAlreadyAddedException implements Exception {
  final String message;
  PlantAlreadyAddedException(this.message);

  @override
  String toString() => message;
}