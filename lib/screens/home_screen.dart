import 'package:camera/camera.dart';
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
      const GalleryScreen(),
      CameraScreen(
        cameraDescription: cameraDescription,
      ),
      const Price(),
    ];
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
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, selectedIndex) {
            return Center(child: screens[selectedIndex]);
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
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
              ],
            );
          },
        ));
  }
}
