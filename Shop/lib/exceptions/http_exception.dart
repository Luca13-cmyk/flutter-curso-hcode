class HttpException implements Exception {
  final String msg;

  const HttpException(this.msg);

  @override
  String toString() {
    // TODO: implement toString
    return msg;
  }
}
