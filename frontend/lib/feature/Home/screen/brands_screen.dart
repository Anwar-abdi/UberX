import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/images.dart';
import '../widget/brand_card.dart';
import 'brand_info.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          children: [
            // Brand List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BrandCard(
                  brandName: 'Honda',
                  image: Images.honda,
                  onTap: () => Get.to(() => BrandInfo(
                        brandName: 'Honda',
                      )),
                ),
                BrandCard(
                    brandName: 'Audi',
                    image: Images.audi,
                    onTap: () => Get.to(() => BrandInfo(
                          brandName: 'Audi',
                        ))),
                BrandCard(
                    brandName: 'Nissan',
                    image: Images.nissan,
                    onTap: () => Get.to(() => BrandInfo(
                          brandName: 'Nissan',
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
