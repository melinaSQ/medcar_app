// ignore_for_file: file_names

abstract class CompanyHomeEvent {}

class ChangeDrawerPage extends CompanyHomeEvent {
  final int pageIndex;
  ChangeDrawerPage({required this.pageIndex});
}

class Logout extends CompanyHomeEvent {}
