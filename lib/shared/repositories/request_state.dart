sealed class RequestState {}

class Loading extends RequestState {}

class Empty extends RequestState {}

class Error extends RequestState {
  final String error;

  Error({required this.error});
}

class Complete extends RequestState {}
