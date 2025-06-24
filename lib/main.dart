import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_demo/core/router/router.dart';
import 'package:store_demo/core/themes/theme.dart';
import 'package:store_demo/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:store_demo/features/cart/presentation/blocs/cart/cart_bloc.dart';
import 'package:store_demo/features/product/presentation/blocs/list_category/list_category_bloc.dart';
import 'package:store_demo/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  initDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(GetUserInformationEvent()),
        ),
        BlocProvider<ListCategoryBloc>(
          create: (context) => sl<ListCategoryBloc>(),
        ),
        BlocProvider<CartBloc>(create: (context) => sl<CartBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(1080, 2400),
        child: MaterialApp.router(
          title: 'Store',
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          themeMode: ThemeMode.light,
          routeInformationParser: AppGoRouter.router.routeInformationParser,
          routerDelegate: AppGoRouter.router.routerDelegate,
          routeInformationProvider: AppGoRouter.router.routeInformationProvider,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
