import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/live_analysis_bloc/live_analysis_bloc.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription cameraDescription;
  const CameraScreen({super.key, required this.cameraDescription});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String? _imagePath;
  late Timer? _timer;

  @override
  void initState() {
    _initializeControllerFuture = _initializeCamera();
    super.initState();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(
      widget.cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    try {
      await _controller.initialize();
      if (!mounted) return;
      setState(() {});
      _startTimer(); // Start the timer
    } on CameraException catch (e) {
      debugPrint("Error initializing camera: $e");
      return Future.error(e);
    }
  }

  Future<void> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return;
    }
    try {
      if (mounted) {
        XFile file = await _controller.takePicture();
        if (mounted) {
          setState(() {
            _imagePath = file.path;
          });
        }
      }
    } on CameraException catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _takePicture();
      if (mounted) {
        context
            .read<LiveAnalysisBloc>()
            .add(LiveAnalysisEvent(imagePath: _imagePath));
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: const Text(
          'CardamomCare',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.info_outline_rounded),
            );
          })
        ],
      ),
      endDrawer: Drawer(
        shape: const Border(),
        width: MediaQuery.sizeOf(context).width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powered By'),
            Image(
              image: AssetImage('assets/images/tfl_logo.png'),
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '@tejas-su @abhay_prabhu @jyothis @dayanand_shenoy',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black26),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              return Center(
                child:
                    Text('Something went wrong while initilizing the camera'),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 600,
                      width: double.infinity,
                      child: CameraPreview(_controller)),
                ),
                BlocBuilder<LiveAnalysisBloc, LiveAnalysisState>(
                  builder: (context, state) {
                    return switch (state) {
                      LiveAnalysisInitial() => Center(
                          child: Center(
                            child: Text(
                              'Initializing the interpretor',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ClassifyingState() => Center(
                          child: ListTile(
                            leading: Text(
                              'Identifying...',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ClassifiedState() => ListTile(
                          title: state.classifyModel.output!.isEmpty
                              ? Text(
                                  'Identifying..',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  state.classifyModel.output![0]['label']
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                          trailing: state.classifyModel.output!.isEmpty
                              ? Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  '${double.parse(state.classifyModel.output![0]['confidence'].toStringAsFixed(2))}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ClassificationErrorState() => Center(
                          child: Text(''),
                        ),
                    };
                  },
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}








//android /data/user/0/com.example.cardamom_care/app_flutter/image.jpg