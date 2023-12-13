import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_pagination/controller/flash_controller.dart';
import 'package:object_pagination/screen/see_all.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final flashController = Get.put(FlashController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Flash Screen"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SeeAllScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 30,
                  color: Colors.white,
                  child: const Center(child: Text("See All")),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => flashController.flashModel.value.data == null
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 2.5 / 2.98),
                    itemCount: flashController.flashModel.value.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  height: 100,
                                  width: double.maxFinite,
                                  image: NetworkImage(flashController
                                      .flashModel.value.data![index].cover!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              flashController
                                  .flashModel.value.data![index].name!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              flashController.flashModel.value.data![index]
                                  .discountedPrice!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
