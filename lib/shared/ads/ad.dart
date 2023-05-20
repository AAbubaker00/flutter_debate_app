// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class CustomeAdWidget extends StatelessWidget {
//   final bool isAdLoaded;
//   final BannerAd bannerAd;

//   CustomeAdWidget({required this.isAdLoaded, required this.bannerAd});

//   @override
//   Widget build(BuildContext context) {
//     if (isAdLoaded) {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Container(
//               width: bannerAd.size.width.toDouble(),
//               height: bannerAd.size.height.toDouble(),
//               alignment: Alignment.center,
//               child: AdWidget(
//                 ad: bannerAd,
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Container(
//         height: 0,
//       );
//     }
//   }
// }
