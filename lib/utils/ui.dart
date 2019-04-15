Future lazyExecute(Duration duration, Function function) async {
  await Future.delayed(duration);
  function();
}
