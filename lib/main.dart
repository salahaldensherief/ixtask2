import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/layout.dart';
import 'presentation/cubits/layout/pizza_layout_cubit.dart';
import 'data/repos/pizza_repo.dart';
import 'data/source/local/pizza_data_source.dart';
void main()  {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context) => PizzaLayoutCubit(PizzaRepo(PizzaDataSource()))..loadPizza(),)  ,
      ],
      child: GestureDetector(
        onTap: ()=>  FocusScope.of(context).unfocus(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: false,
          ),
          home: Layout(),
        ),
      ),
    );
  }
}