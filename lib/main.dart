import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task2ix/presentation/cubits/fav/fav_cubit.dart';
import 'package:task2ix/presentation/cubits/layout/pizza_layout_cubit.dart';
import 'package:task2ix/presentation/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repos/pizza_repo.dart';
import 'data/source/local/pizza_data_source.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:
          BlocProvider(
            create:  (context) => PizzaLayoutCubit(PizzaRepo(PizzaDataSource()))..loadPizza(),
        child: const Layout(),
      )

    );
  }
}