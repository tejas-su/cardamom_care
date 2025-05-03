import 'package:camera/camera.dart';
import 'package:cardamom_care/blocs/chat_bloc/chat_bloc.dart';
import 'package:cardamom_care/blocs/chat_bloc/query_field_cubit.dart';
import 'package:cardamom_care/blocs/web_view_bloc/web_view_bloc.dart';
import 'package:cardamom_care/blocs/web_view_bloc/web_view_event.dart';
import 'package:cardamom_care/models/chat_model.dart';
import 'package:cardamom_care/repository/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'blocs/classify_bloc/classify_bloc.dart';
import 'blocs/live_analysis_bloc/live_analysis_bloc.dart';
import 'cubit/navigation_cubit.dart';
import 'repository/helper_repository.dart';
import 'screens/loading_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ChatModelAdapter());

  final hiveService = await HiveService.init();

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
                )),
        BlocProvider(
            create: (context) => WebViewBloc()..add(WebViewLoadEvent())),
        BlocProvider(
            create: (context) =>
                ChatBloc(hiveService: hiveService)..add(OnLoadChatsEvent())),
        BlocProvider(create: (context) => QueryFieldCubit())
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
