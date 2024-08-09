import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shopliax_todo/Config/routes/route_location.dart';
import 'package:shopliax_todo/Providers/photo_provider.dart';

class PhotoScreen extends ConsumerWidget {
  static PhotoScreen builder(BuildContext context, GoRouterState state) =>
      const PhotoScreen();
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoListAsyncValue = ref.watch(photoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go(RouteLocation.home);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: photoListAsyncValue.when(
          data: (photos) {
            // display the items  from the Api endpoint
            return ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.network(photo.thumbnailUrl),
                    title: Text(photo.title),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
