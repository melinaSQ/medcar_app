// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

class CompanyHomeState extends Equatable {

  final int pageIndex;

  const CompanyHomeState({
    this.pageIndex = 0
  });

  CompanyHomeState copyWith({
    int? pageIndex
  }) {
    return CompanyHomeState(pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  List<Object?> get props => [pageIndex];

}