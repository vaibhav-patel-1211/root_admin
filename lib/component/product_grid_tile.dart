import 'package:flutter/material.dart';
import 'package:root_admin/component/network_image_loader.dart';
import '../../constants.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.brandName,
    this.priceAfterDiscount,
    this.press,
  });

  final String image, title, brandName;
  final double price;
  final double? priceAfterDiscount;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultBorderRadious),
          border: Border.all(
            color: lightGreyColor,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(defaultBorderRadious),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NetworkImageWithLoader(
                    image,
                    radius: defaultBorderRadious,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Colors.blue[100],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(defaultBorderRadious),
                  bottomRight: Radius.circular(defaultBorderRadious),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Price Section
                    priceAfterDiscount != null
                        ? Row(
                            children: [
                              Text(
                                "${priceAfterDiscount!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Color(0xFF31B0D8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            "${price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Color(0xFF31B0D8),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
