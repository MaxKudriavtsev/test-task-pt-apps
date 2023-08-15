abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}

class LoginWithGooglePressed extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
