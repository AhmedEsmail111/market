import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '/controller/favorites/favorites_cubit.dart';
import '/controller/favorites/favorites_states.dart';

class BuildFavIcon extends StatelessWidget {
  final int id;
  const BuildFavIcon({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
      listener: (ctx, state) {
        // if (state is ChangeFaveFailureState) {
        //   buildToastMessage(
        //     message: 'Something went wrong!',
        //     gravity: ToastGravity.CENTER,
        //     textColor: Colors.white,
        //     background: Theme.of(context).colorScheme.error.withOpacity(0.8),
        //   );
        // }
      },
      builder: (context, state) {
        final cubit = FavoritesCubit.get(context);
        return IconButton(
          onPressed: () {
            cubit.changeFavoriteStatus(id, cubit.favorites.containsKey(id));
          },
          style: IconButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          ),
          icon: Icon(
            cubit.isFavorite(id) ? Iconsax.heart : Iconsax.heart_add_copy,
            color: cubit.isFavorite(id)
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSecondary,
          ),
        );
      },
    );
  }
}
