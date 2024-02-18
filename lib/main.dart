import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/controller/language/language_cubit.dart';
import 'package:shop_app/controller/language/language_states.dart';
import 'package:shop_app/shared/network/local/local_database.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '/bloc_observer.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/favorites/favorites_cubit.dart';
import '/layout/shop_layout.dart';
import '/modules/login/login_screen.dart';
import '/modules/onboarding/onboarding_screen.dart';
import '/shared/constants/constants.dart';
import '/shared/network/local/shared_preference.dart';
import '/shared/network/remote/remote.dart';
import 'controller/addresses/addresses_cubit.dart';
import 'controller/home/home_cubit.dart';
import 'controller/settings/settings_cubit.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppConstants.publishableKey;
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await LocalDatabase.createDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (ctx) => AddressesCubit()..getAddresses(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..setData(),
        ),
        BlocProvider(
          create: (context) => CartCubit()..getOrders(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          final isBoardingDone =
              CacheHelper.getData(key: AppConstants.isBoarding) ?? false;
          final userToken = CacheHelper.getData(key: AppConstants.token);
          return BlocBuilder<ShopCubit, ShopStates>(
            builder: (context, state) {
              final cubit = ShopCubit.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                locale: cubit.locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                supportedLocales: L10n.all,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    titleTextStyle: const TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color.fromARGB(255, 52, 9, 127)),
                  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedLabelStyle: const TextStyle().copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                    ),
                    selectedItemColor: Theme.of(context).colorScheme.primary,
                    unselectedItemColor:
                        Theme.of(context).colorScheme.secondary,
                    type: BottomNavigationBarType.fixed,
                  ),
                  textTheme: const TextTheme().copyWith(
                    bodyLarge: const TextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    bodyMedium: const TextStyle().copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: AppColors.darKBackground,
                    titleTextStyle: const TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                    actionsIconTheme: const IconThemeData().copyWith(
                      color: Colors.white,
                    ),
                  ),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 25, 1, 66),
                    // brightness: Brightness.dark,
                  ),
                  scaffoldBackgroundColor: AppColors.darKBackground,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: AppColors.darKBackground,
                    unselectedItemColor:
                        const Color.fromARGB(255, 192, 187, 187),
                    selectedLabelStyle: const TextStyle().copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    selectedItemColor: Theme.of(context).colorScheme.primary,
                    type: BottomNavigationBarType.fixed,
                  ),
                  textTheme: const TextTheme().copyWith(
                    bodyLarge: const TextStyle().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    bodyMedium: const TextStyle().copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  useMaterial3: true,
                  // inputDecorationTheme: InputDecorationTheme(
                  //     activeIndicatorBorder: BorderSide.none)
                ),
                themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                home: isBoardingDone
                    ? userToken != null
                        ? const ShopLayout()
                        : const LoginScreen()
                    : const OnBoardingScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
