import 'package:flutter/material.dart';
import 'package:root_admin/component/network_image_loader.dart';

import '../../constants.dart';

class ProductCard extends StatelessWidget {
  // constructor and parameters
  const ProductCard({
    super.key,
    required this.image, //url of image
    required this.brandName, // brand name
    required this.title, // name of product
    required this.price, // price of product
    this.priceAfetDiscount, // discounted price
    this.dicountpercent, // dicount percentage
    this.press, // callback function
  });

  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // outlined button
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
          minimumSize: const Size(140, 220),
          maximumSize: const Size(140, 220),
          padding: const EdgeInsets.all(8)),
      child: Column(
        children: [
          // image section
          AspectRatio(
            aspectRatio: 1.5,
            child: Stack(
              children: [
                NetworkImageWithLoader(image, radius: defaultBorderRadious),
                if (dicountpercent != null)
                  // display discount badge at top-right corner if dicountpercent is not null
                  Positioned(
                    right: defaultPadding / 2,
                    top: defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                      child: Text(
                        "$dicountpercent% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),

          // fills remaining verticle space
          // product info section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // brandname
                Text(
                  brandName.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 10),
                ),
                const SizedBox(height: defaultPadding / 2),

                // product tile
                Text(
                  title,
                  maxLines: 2,
                  // limit the text to 2 lines
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 12),
                ),

                const Spacer(),

                // price section
                // priceAfetDiscount is provided Shows the discounted price in blue and bold.
                // Displays the original price with a strikethrough.
                priceAfetDiscount != null
                    ? Row(
                        children: [
                          Text(
                            "\$$priceAfetDiscount",
                            style: const TextStyle(
                              color: Color(0xFF31B0D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: defaultPadding / 4),
                          Text(
                            "\$$price",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )

                    // if not only display original price
                    : Text(
                        "\$$price",
                        style: const TextStyle(
                          color: Color(0xFF31B0D8),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
