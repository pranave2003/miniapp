void main() {
  // Example 1
  Map<String, int> wordCount1 = {"apple": 4, "banana": 2, "cherry": 5};
  int highestFrequency1 = -1;
  List<String> highestFrequencyWords1 = [];

  wordCount1.forEach((word, frequency) {
    if (frequency > highestFrequency1) {
      highestFrequency1 = frequency;
      highestFrequencyWords1 = [word];
    } else if (frequency == highestFrequency1) {
      highestFrequencyWords1.add(word);
    }
  });

  print(
      'Highest frequency word(s) in wordCount1: $highestFrequencyWords1'); // Output: [cherry]
}
