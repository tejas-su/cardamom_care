import 'package:camera/camera.dart';
import 'package:cardamom_care/widgets/file_upload.dart';
import 'package:cardamom_care/widgets/results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/classify_bloc/classify_bloc.dart';

class GalleryScreen extends StatelessWidget {
  final CameraDescription cameraDescription;
  const GalleryScreen({super.key, required this.cameraDescription});

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
      body: Column(
        children: [
          BlocBuilder<ClassifyBloc, ClassifyState>(
            builder: (context, state) {
              return switch (state) {
                //Initial state: ask the user to either upload the image or take a photo
                ClassifyInitialState() => Expanded(
                    child: FileUpload(
                      onTap: () => context
                          .read<ClassifyBloc>()
                          .add(OnSelectPhotoEvent()),
                    ),
                  ),
                //Show a loading animation when the image is being classified
                ClassifyingState() =>
                  Center(child: CircularProgressIndicator()),
                //Results: show the image and the confidence score
                ClassifiedState() => Results(
                    file: state.classifyModel.file!,
                    label: (state.classifyModel.output?.isNotEmpty ?? false)
                        ? state.classifyModel.output![0]['label']
                        : 'No result',
                    confidence:
                        (state.classifyModel.output?.isNotEmpty ?? false)
                            ? state.classifyModel.output![0]['confidence']
                            : 0,
                  ),
                //Display the error message if something goes wrong
                ErrorState() => Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              'Something went wrong',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                                onPressed: () => context
                                    .read<ClassifyBloc>()
                                    .add(OnRefreshEvent()),
                                icon: Icon(Icons.refresh_rounded))
                          ],
                        ),
                      ),
                    ),
                  ),
              };
            },
          ),
        ],
      ),
    );
  }
}
