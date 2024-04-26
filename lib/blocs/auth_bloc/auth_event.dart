part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class RequestOtpAuthEvent extends AuthEvent {
  final Map<String, dynamic> map;
  const RequestOtpAuthEvent({required this.map});
  @override
  List<Object?> get props => [map];
}
class OtpVerificationAuthEvent extends AuthEvent {
  final Map<String, dynamic> map;
  const OtpVerificationAuthEvent({required this.map});
  @override
  List<Object?> get props => [map];
}
class GoogleAuthEvent extends AuthEvent {
  const GoogleAuthEvent();
  @override
  List<Object?> get props => [];
}
class FacebookAuthEvent extends AuthEvent {
  const FacebookAuthEvent();
  @override
  List<Object?> get props => [];
}
