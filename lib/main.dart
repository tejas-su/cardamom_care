import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/classify_bloc/classify_bloc.dart';
import 'blocs/live_analysis_bloc/live_analysis_bloc.dart';
import 'cubit/navigation_cubit.dart';
import 'repository/helper_repository.dart';
import 'screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Fetch the properties of the camera initially
  CameraDescription cameraDescription = (await availableCameras()).first;
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(
            create: (context) => ClassifyBloc(
                helperRepository:
                    HelperRepository(cameraDescription: cameraDescription)
                      ..loadmodel())),
        BlocProvider(
            create: (context) => LiveAnalysisBloc(
                  helperRepository:
                      HelperRepository(cameraDescription: cameraDescription),
                ))
      ],
      child: MyApp(
        cameraDescription: cameraDescription,
      )));
}

class MyApp extends StatelessWidget {
  final CameraDescription cameraDescription;
  const MyApp({super.key, required this.cameraDescription});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: LoadingScreen(
        cameraDescription: cameraDescription,
      ),
    );
  }
}
