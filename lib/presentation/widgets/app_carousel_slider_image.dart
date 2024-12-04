import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/domain/models/response/dashboard/banner_entity.dart';

import 'app_image.dart';

class AppCarouselSliderImage extends StatefulWidget {
  const AppCarouselSliderImage({super.key, required this.bannerList});

  final List<BannerEntity> bannerList;

  @override
  State<AppCarouselSliderImage> createState() => _AppCarouselSliderImageState();
}

class _AppCarouselSliderImageState extends State<AppCarouselSliderImage> {
  CarouselSliderController controller = CarouselSliderController();
  int initialPage = 0;
  late List<BannerEntity> bannerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerList = widget.bannerList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
            carouselController: controller,
            items: bannerList.map((banner) {
              return AppImage(
                banner.image ?? 'https://hoc24.vn/images/banner/banner1.png',
                double.infinity,
                Get.size.width * 0.35,
                circular: 16,
              );
            }).toList(),
            options: CarouselOptions(
              height: Get.size.width * 0.35,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  initialPage = index;
                });
              },
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerList.asMap().entries.map((imageUrl) {
            return InkWell(
              onTap: () {
                controller.jumpToPage(imageUrl.key);
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                height: initialPage == imageUrl.key ? 8 : 6,
                width: initialPage == imageUrl.key ? 8 : 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: initialPage == imageUrl.key ? AppColors.light : AppColors.lightGrey,
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
