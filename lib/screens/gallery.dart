import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/classify_bloc/classify_bloc.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<ClassifyBloc, ClassifyState>(
            builder: (context, state) {
              if (state is ClassifyInitial) {
                return Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Please select an image from the gallery or take a photo !',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                );
              }
              if (state is ClassifyingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ClassifiedState) {
                double confidence =
                    state.classifyModel.output![0]['confidence'];
                double roundedConfidenceValue =
                    double.parse(confidence.toStringAsFixed(2));
                return Expanded(
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Image.file(state.classifyModel.file!),
                            ListTile(
                              title: Text(
                                state.classifyModel.output![0]['label']
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              trailing: Text(
                                '$roundedConfidenceValue',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ))
                  ]),
                );
              }
              if (state is Errorstate) {
                return Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        state.errormessage,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
          //Buttons for choosing fromt the gallery or take a picture

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton.extended(
                heroTag: 'Open Camera',
                backgroundColor: Colors.green.shade100,
                elevation: 0,
                icon: const Icon(
                  Icons.camera,
                  size: 24,
                ),
                onPressed: () =>
                    context.read<ClassifyBloc>().add(OnTakePhotoEvent()),
                label: const Text('Take a photo'),
              ),
              //Pick from gallery
              FloatingActionButton.extended(
                heroTag: 'Open Gallery',
                backgroundColor: Colors.green.shade100,
                elevation: 0,
                icon: const Icon(
                  Icons.image,
                  size: 24,
                ),
                onPressed: () =>
                    context.read<ClassifyBloc>().add(OnSelectPhotoEvent()),
                label: const Text('Select a photo'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
