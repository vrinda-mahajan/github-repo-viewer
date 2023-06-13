import 'package:auto_route/auto_route.dart';
import 'package:github_repo_viewer/core/presentation/routes/app_routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: AuthorizationRoute.page, path: '/auth'),
        AutoRoute(page: StarredReposRoute.page),
      ];
}
