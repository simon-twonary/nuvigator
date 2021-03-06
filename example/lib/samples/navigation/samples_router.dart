import 'package:example/samples/modules/sample_two/bloc/sample_flow_bloc.dart';
import 'package:example/samples/modules/sample_two/navigation/sample_two_router.dart';
import 'package:flutter/material.dart';
import 'package:nuvigator/nuvigator.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../bloc/samples_bloc.dart';
import '../modules/sample_one/navigation/sample_one_router.dart';

part 'samples_router.g.dart';

@NuRouter()
class SamplesRouter extends Router {
  @override
  String get deepLinkPrefix => 'deepprefix';

  @NuRoute()
  ScreenRoute<void> home() => ScreenRoute(
        builder: (context) => HomeScreen(),
      );

  @NuRoute()
  ScreenRoute<String> second({@required String testId}) => ScreenRoute(
        builder: Nuvigator(
          router: SampleTwoRouter(testId: testId),
          initialRoute: SampleTwoRoutes.screenOne,
          screenType: cupertinoScreenType,
          wrapper: (BuildContext context, Widget child) => Provider(
            create: (_) => SampleFlowBloc(),
            child: child,
          ),
        ),
      );

  @NuRouter()
  final SampleOneRouter sampleOneRouter = SampleOneRouter();

  @override
  WrapperFn get screensWrapper => (BuildContext context, Widget child) {
        return Provider<SamplesBloc>.value(
          value: SamplesBloc(),
          child: child,
        );
      };

  @override
  Map<RouteDef, ScreenRouteBuilder> get screensMap => _$screensMap;

  @override
  List<Router> get routers => _$routers;
}
