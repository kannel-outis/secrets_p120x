import 'package:equatable/equatable.dart';

class Exceptions extends Equatable {
  final String message;

  Exceptions({this.message});

  @override
  String toString() => message;

  @override
  List<Object> get props => [message];
}
