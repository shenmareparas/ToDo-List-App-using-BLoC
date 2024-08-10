import 'package:bloc_test/modules/bottom_navigation/block/bottom_navigation_bloc.dart';
import 'package:bloc_test/modules/main/ui/main_screen.dart';
import 'package:bloc_test/modules/main/ui/pages/tasks/block/exports.dart';
import 'package:bloc_test/modules/theme_switcher/block/exports.dart';
import 'package:bloc_test/services/app_router.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => ThemeSwitcherBloc()),
        BlocProvider(create: (context) => BottomNavigationBloc()),
      ],
      child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Todos',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            themeMode: state.themeMode,
            darkTheme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.onGenerateRoute,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
