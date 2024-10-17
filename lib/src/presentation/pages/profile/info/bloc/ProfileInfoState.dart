
import 'package:equatable/equatable.dart';
import 'package:medcar_app/src/domain/models/user.dart';

class ProfileInfoState extends Equatable {

  final User? user;

  ProfileInfoState({this.user});

  ProfileInfoState copyWith({
    User? user
  }) {
    return ProfileInfoState(
      user: user
    );
  }

  @override
  List<Object?> get props => [user];

}
