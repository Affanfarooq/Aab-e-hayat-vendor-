import 'package:aabehayat_vendor/Models/CustomerModel.dart';
import 'package:aabehayat_vendor/Services/CustomerRequestService.dart';
import 'package:aabehayat_vendor/Services/NotificationService.dart';
import 'package:aabehayat_vendor/Widgets/CustomSnackBars.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  final RequestService requestService = RequestService();
  final NotificationService notificationService = NotificationService();

  var pendingRequests = <Customer>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchPendingRequests();
    super.onInit();
  }

  void fetchPendingRequests() async {
    isLoading(true);
    var result = await requestService.getPendingRequests('1740422334303');
    if (result.isSuccess) {
      pendingRequests.assignAll(result.data!);
    } else {
      SnackbarUtils.showError(result.errorMessage);
    }
    isLoading(false);
  }

  void acceptRequest(String customerId) async {
    var result = await requestService.updateRequestStatus(customerId, "accepted");
    if (result.isSuccess) {
      pendingRequests.removeWhere((c) => c.customerId == customerId);
     final NotificationService notificationService = NotificationService();
      // notificationService.sendPushNotification(customerId, "Your request has been accepted!");
    } else {
      SnackbarUtils.showError(result.errorMessage);
    }
  }

  void declineRequest(String customerId) async {
    var result = await requestService.updateRequestStatus(customerId, "declined");
    if (result.isSuccess) {
      pendingRequests.removeWhere((c) => c.customerId == customerId);
    } else {
      SnackbarUtils.showError(result.errorMessage);
    }
  }
}
