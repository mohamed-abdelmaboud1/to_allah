import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TableShimmer extends StatelessWidget {
  const TableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the Shimmer date
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 15,
            width: 150,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[300]!,
            ),
          ),
        ),
        // Display the Shimmer table body
        ...List.generate(
          8,
          (index) => Row(
            children: [
              for (int i = 0; i < 3; i++)
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
