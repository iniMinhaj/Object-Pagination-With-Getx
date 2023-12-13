import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/flash_model.dart';

class FlashController extends GetxController {
  ScrollController scrollController = ScrollController();

  bool isLoading = false;
  int paginate = 1;
  int page = 1;
  int itemPerPage = 8;
  final flashModel = FlashModel().obs;

  final flashList = <Datum>[].obs;
  bool hasMoreData = false;

  Future<void> fetchFlashSale() async {
    const baseUrl = "https://shopperz.foodking.dev";
    isLoading = true;

    try {
      final response = await http.get(Uri.parse(
          "$baseUrl/api/frontend/product/flash-sale-products?paginate=${paginate.toString()}&page=${page.toString()}&per_page=${itemPerPage.toString()}"));
      isLoading = false;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        flashModel.value = FlashModel.fromJson(data);
        flashList.value += flashModel.value.data!;

        print("FlashList Length === ${flashList.length}");

        final meta = data["meta"];
        final lastPage = meta["last_page"];
        print("Current Page = $page");
        print("lastPage = $lastPage");
        if (page <= lastPage) {
          hasMoreData = true;
          page++;
        } else {
          hasMoreData = false;
        }
      }
    } catch (e) {
      print(e.toString());
      isLoading = false;
    } finally {
      isLoading = false;
    }
  }

// Using ScrollContoller .....................
  void loadMoreData() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // User has reached the end of the list, fetch more data
        fetchFlashSale();
      }
    });
  }

  // Using ScrollNotification....................
  // void seeMore() {
  //   fetchFlashSale();
  // }

  // bool isEndOfList(ScrollNotification scrollInfo) {
  //   return scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
  // }

  // End not

  // Reset State
  void resetState() {
    flashList.clear();
    page = 1; // Reset pagination parameters
    hasMoreData = false; // Reset the flag for more data availability
  }

  @override
  void onInit() {
    fetchFlashSale();
    super.onInit();
  }
}
