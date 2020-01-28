import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class Failure extends Equatable {
}

class FailureBadParams extends Failure {
  @override
  List<Object> get props => [];
}

class FailureNotImplemented extends Failure {
  @override
  List<Object> get props => [];
}

class FailureLmCore extends Failure {
  final String error;
  @override
  List<Object> get props => [error];

  FailureLmCore({this.error = ""});
}
