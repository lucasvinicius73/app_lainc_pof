sealed class RequestState {}

class Loading extends RequestState {}

class Empty extends RequestState {}

class Error extends RequestState {
  final String message;

  Error({required this.message});
}

class Complete extends RequestState {}
