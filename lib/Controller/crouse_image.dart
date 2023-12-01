import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/api.dart';
import '../Utilies/constant.dart';

class CrouselController extends ChangeNotifier {
  String _text =
      'Currently there is any issue like no internet or added some announcement from the backend';

  List<String> _crousellist = [
    "https://static.vecteezy.com/system/resources/previews/014/914/307/original/online-auction-3d-illustration-of-an-auctioneer-talking-into-a-microphone-and-selecting-a-buyer-s-bid-vector.jpg",
    // "https://zeropark.com/blog/wp-content/uploads/sites/2/2020/09/Z_Bidding_vs_Waterfall_bidding_header_2020_09_08.png",
    "https://img.freepik.com/free-vector/auction-infographic-set-with-bid-tips-symbols-isometric-vector-illustration_1284-78378.jpg?w=2000",
  ];

  List<String> get crouselL => [..._crousellist];
  String get marquesText => _text;

  updatListAndtext(
      {required String marqueText, required List<String> crouselImage}) {
    if (marqueText.isNotEmpty) {
      _text = marqueText;
    }
    if (crouselImage.isNotEmpty) {
      _crousellist = crouselImage;
    }

    notifyListeners();
  }

  Future fethcSliderImageText() async {
    final url = Uri.parse(Api.slider);
    final tokenNew = sharedPreferences.getString("token");
    http.Response response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $tokenNew',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodData = await jsonDecode(response.body);
      bool status = decodData['status'];

      if (status) {
        var data = await decodData['data'] ?? null;

        if (data != null) {
          String newtext = '';

          var sliderText = await data['slide_text'];
          if (sliderText != null) {
            newtext = await sliderText['title_one'];
          }
          var imageData = data['slider_images'];
          List<String> imageslist = [];
          for (var image in imageData) {
            imageslist.add(image['title_image']);
          }
          updatListAndtext(marqueText: newtext, crouselImage: imageslist);
          var contactNumber = await data['whatsapp_number'];
          if (contactNumber != null) {
            String number = await contactNumber['title_one'];
            await sharedPreferences.setString('contactNumber', number);
          }
          var share = await data['app_share_url'];
          if (share != null) {
            String shareUrl = share['title_one'];
            await sharedPreferences.setString('shareUrl', shareUrl);
          }
        }
      } else {
        return;
      }
    }
  }
}
