import 'package:bloc_test/modules/bin/ui/bin_screen.dart';
import 'package:bloc_test/modules/main/ui/main_screen.dart';
import 'package:bloc_test/modules/main/ui/pages/tasks/block/exports.dart';
import 'package:bloc_test/modules/theme_switcher/ui/widgets/ThemeSwitchButton.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  void _goTo(BuildContext context, String route) {
    final navigator = Navigator.of(context);
    navigator.pop();
    if (ModalRoute.of(context)?.settings.name != route) {
      navigator.pushNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return Column(
                children: [
                  const CircleAvatar(
                    radius: 68,
                    child: Text(
                      'ToDo',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('My tasks'),
                    trailing: Text(
                      "${state.doneTasksCount}/${state.tasksCount}",
                    ),
                    onTap: () => _goTo(context, MainScreen.routeName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Deleted tasks'),
                    trailing: Text(
                      "${state.trashedTasksCount}",
                    ),
                    onTap: () => _goTo(context, BinScreen.routeName),
                  ),
                  const Spacer(),
                  const ThemeSwitchButton(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
