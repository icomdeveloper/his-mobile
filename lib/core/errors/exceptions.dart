class Customexception implements Exception {
  final String message;

  Customexception(this.message);
  @override
  toString() {
    return message.toString();
  }
}
