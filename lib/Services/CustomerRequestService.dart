import 'package:aabehayat_vendor/Models/CustomerModel.dart';
import 'package:aabehayat_vendor/Utils/ResponseClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ResponseClass<List<Customer>>> getPendingRequests(String shopId) async {
    try {
      var querySnapshot = await _firestore
          .collection('customers')
          .where('registeredShopId', isEqualTo: shopId)
          .where('status', isEqualTo: "pending")
          .get();

      List<Customer> customers = querySnapshot.docs.map((doc) {
        return Customer.fromJson(doc.data());
      }).toList();

      return ResponseClass.success(customers);
    } catch (e) {
      return ResponseClass.error(e.toString());
    }
  }

  Future<ResponseClass<String>> updateRequestStatus(String customerId, String status) async {
    try {
      await _firestore.collection('customers').doc(customerId).update({
        'status': status,
      });
      return ResponseClass.success("Request status updated successfully");
    } catch (e) {
      return ResponseClass.error(e.toString());
    }
  }
}
