import 'package:aabehayat_vendor/Controllers/CustomerRequestController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingRequestsScreen extends StatelessWidget {
  final RequestController requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pending Requests")),
      body: Obx(() {
        if (requestController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (requestController.pendingRequests.isEmpty) {
          return Center(child: Text("No pending requests"));
        }
        return ListView.builder(
          itemCount: requestController.pendingRequests.length,
          itemBuilder: (context, index) {
            var customer = requestController.pendingRequests[index];
            return ListTile(
              title: Text(customer.name),
              subtitle: Text(customer.phone),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () => requestController.acceptRequest(customer.customerId),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => requestController.declineRequest(customer.customerId),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
