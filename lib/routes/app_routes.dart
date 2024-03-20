/**
 * Created by Jaimin on 20/03/24.
 */

part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const USERDETAIL = _Paths.USERDETAIL;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const USERDETAIL = '/userDetail';
}
