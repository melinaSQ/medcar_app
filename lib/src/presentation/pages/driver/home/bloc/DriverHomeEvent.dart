// ignore_for_file: file_names

abstract class DriverHomeEvent {}

class ChangeDrawerPage extends DriverHomeEvent {
  final int pageIndex;
  ChangeDrawerPage({ required this.pageIndex });
}

class Logout extends DriverHomeEvent {}