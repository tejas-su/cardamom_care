import 'package:camera/camera.dart';
import 'package:cardamom_care/screens/visualization_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navigation_cubit.dart';
import 'camera_screen.dart';
import 'gallery.dart';
import 'price_screen.dart';

class HomeScreen extends StatelessWidget {
  final CameraDescription cameraDescription;
  const HomeScreen({super.key, required this.cameraDescription});

  @override
  Widget build(BuildContext context) {
    List screens = [
      GalleryScreen(
        cameraDescription: cameraDescription,
      ),
      CameraScreen(
        cameraDescription: cameraDescription,
      ),
      const PricePredictionScreen(),
      const VisualizationScreen(),
    ];
    return Scaffold(body: BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return Center(child: screens[selectedIndex]);
      },
    ), bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return NavigationBar(
          indicatorColor: Colors.green.shade200,
          elevation: 10,
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) =>
              context.read<NavigationCubit>().onDestinationSelected(value),
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.image_rounded),
                icon: Icon(Icons.image_outlined),
                label: 'Gallery'),
            NavigationDestination(
                selectedIcon: Icon(Icons.camera_rounded),
                icon: Icon(Icons.camera_outlined),
                label: 'Live Camera'),
            NavigationDestination(
                selectedIcon: Icon(Icons.bar_chart_rounded),
                icon: Icon(Icons.bar_chart_rounded),
                label: 'Prediction'),
            NavigationDestination(
                selectedIcon: Icon(Icons.timeline_rounded),
                icon: Icon(Icons.timeline_rounded),
                label: 'Visualization'),
          ],
        );
      },
    ));
  }
}
