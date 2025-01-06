class CountdownModel {
  final String currentYear;
  final String nextYear;
  bool isPlaying;
  bool showCountdown;
  int secondsLeft;

  CountdownModel({
    this.currentYear = "2024",
    this.nextYear = "2025",
    this.isPlaying = false,
    this.showCountdown = false,
    this.secondsLeft = 10,
  });
}