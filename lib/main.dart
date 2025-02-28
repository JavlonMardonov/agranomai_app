import 'package:agranom_ai/bloc/image_upload_bloc/image_upload_bloc.dart';
import 'package:agranom_ai/common/app/injcetion_container.dart';
import 'package:agranom_ai/common/constant/network_constant.dart';
import 'package:agranom_ai/common/constant/prefers_key.dart';
import 'package:agranom_ai/data/repositories/home_repo.dart';
import 'package:agranom_ai/presentation/screens/image_scrren.dart';
import 'package:agranom_ai/presentation/screens/landing_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  final token = getIt<SharedPreferences>()
      .setString(PrefsKeys.tokenKey, NetworkConstants.token);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageUploadBloc>(
            create: (context) => ImageUploadBloc(getIt<HomeRepo>())),
        // BlocProvider<AnotherBloc>(create: (context) => AnotherBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => const LandingPage(),
          '/camera': (context) => const CameraScreen(),
        },
      ),
    );
  }
}
