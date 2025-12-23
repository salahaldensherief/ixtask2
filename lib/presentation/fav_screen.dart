import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2ix/data/models/pizza_item_model.dart';

import 'cubits/fav/fav_cubit.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: BlocBuilder<FavCubit, FavState>(
        builder: (context, state) {

          final cubit = context.read<FavCubit>();

          if (cubit.favorites.isEmpty) {
            return const Center(
              child: Text(
                "No favorites added yet!",
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return ListView.builder(
            itemCount: cubit.favorites.length,
            itemBuilder: (context, index) {
              final pizza = cubit.favorites[index];

              return ListTile(
                leading: Text(
                  pizza.icon ?? "🍕",
                  style: const TextStyle(fontSize: 25),
                ),
                title: Text(pizza.name),
                subtitle: Text(pizza.description),
                trailing: Text(
                  "${pizza.basePrice} \$",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
