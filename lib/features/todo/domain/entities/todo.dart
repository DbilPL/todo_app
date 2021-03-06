import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class TODO extends Equatable {
  final String title, body;

  final DateTime date;

  final bool isComplete;

  const TODO(
      {@required this.isComplete,
      @required this.date,
      @required this.title,
      @required this.body});

  @override
  List<Object> get props => [title, body, date, isComplete];
}
