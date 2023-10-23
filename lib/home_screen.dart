import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_ai/cubit/image_cubit.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageCubit, ImageState>(
      listener: (context, state) {},
      builder: (context, state) {
        ImageCubit cubit = ImageCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('slazzer app Ai '),
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              IconButton(
                  onPressed: () {
                    cubit.getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image_outlined)),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: cubit.imageFile == null
                            ? const Text(
                                'Please Select Image',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.teal),
                              )
                            : Image.file(cubit.imageFile!)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        cubit.removeBg(cubit.imageFile!);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal),
                      child: Text('remove background')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: cubit.imagePath == null
                          ? Container(
                              width: 300,
                              height: 300,
                              color: Colors.grey[300]!,
                              child: const Icon(
                                Icons.image,
                                size: 100,
                              ),
                            )
                          : Image.memory(
                              cubit.imagePath!,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
