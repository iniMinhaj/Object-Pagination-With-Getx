import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:object_pagination/controller/flash_controller.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({Key? key}) : super(key: key);

  @override
  _SeeAllScreenState createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final FlashController flashController = Get.find<FlashController>();

  @override
  void initState() {
    super.initState();
    flashController.loadMoreData();
  }

  @override
  void dispose() {
    flashController.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("See All Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () =>

              // NotificationListener<ScrollNotification>(
              //   onNotification: (notification) {
              //     if (flashController.isEndOfList(notification)) {
              //       flashController.seeMore();
              //     }
              //     return false;
              //   },
              GridView.builder(
            controller: flashController.scrollController,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: .85,
            ),
            itemCount: flashController.flashList.length +
                (flashController.hasMoreData == true ? 1 : 0),
            // (flashController.hasMoreData.value == true ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == flashController.flashList.length) {
                // Reached the end, display loading indicator or end message

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final data = flashController.flashList[index];
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
                          image: NetworkImage(data.cover!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data.name!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      data.discountedPrice!,
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
          //  ),
        ),
      ),
    );
  }
}
