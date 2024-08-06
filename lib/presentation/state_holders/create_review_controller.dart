import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController {
  bool _createReviewInProgress = false;
  String _message = '';

  bool get createReviewInProgress => _createReviewInProgress;
  String get message => _message;
  final _homecontrol = Get.put(HomeController());

  Future<void> addReview(NewProduct pd, comment) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    _createReviewInProgress = true;
    update();
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('products')
          .where('id', isEqualTo: pd.id)
          .get();
      Review newreview = Review(
          comment: comment,
          fullname: "${_homecontrol.firstname} ${_homecontrol.lastName}",
          rating: "5",
          userId: "");
      pd.ratings?.reviews?.add(newreview);

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({'ratings': pd.ratings?.toJson()});
      }
      _homecontrol.fetchProducts();
      _createReviewInProgress = false;
      update();
      Get.back();
      Get.back();
      Get.snackbar('done', "review added done");
    } catch (e) {
      _createReviewInProgress = false;
      update();
      // TODO
    }
  }
}
