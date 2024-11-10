import 'package:api_integration_app/controller/product_controller.dart';
import 'package:api_integration_app/view/detail_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeStore extends GetView<ProductController> {
  HomeStore({super.key});
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: controller.obx(
          (state) => GridView.builder(
                shrinkWrap: true,
                //  physics: NeverScrollableScrollPhysics(),
                itemCount: state!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => DetailProductScreen(
                                product: state[index],
                              ));
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: '${state[index].id}',
                                  child: CachedNetworkImage(
                                    imageUrl: state[index].image.toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        productShrimmerSingle(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),

                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       image: DecorationImage(
                                  //           fit: BoxFit.cover,
                                  //           image: NetworkImage(state[index]
                                  //               .image
                                  //               .toString()))),
                                  // ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  state[index].title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$ ${state[index].price}',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'view : ${state[index].rating!.count}',
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))),
              ),
          onEmpty: const Center(
            child: Text('Empty'),
          ),
          onLoading: productShrimmer()),
    );
  }

  Widget productShrimmer() {
    return GridView.builder(
        shrinkWrap: true,
        //  physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          mainAxisExtent: 250,
        ),
        itemBuilder: (context, index) => Shimmer.fromColors(
              period: const Duration(milliseconds: 2500),
              baseColor: Colors.blueGrey,
              highlightColor: Colors.grey,
              child: Container(
                margin: const EdgeInsets.all(4),
                width: 200,
                height: 150,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ));
  }

  Widget productShrimmerSingle() {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 2500),
        baseColor: Colors.blueGrey,
        highlightColor: Colors.grey,
        child: Container(
          margin: const EdgeInsets.all(4),
          width: 180,
          height: 150,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ));
  }
}
