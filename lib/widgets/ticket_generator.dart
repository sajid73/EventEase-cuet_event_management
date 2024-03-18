import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data_controller.dart';

class TicketPage extends StatelessWidget {
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (dataController.joinedEvents.isEmpty) {
          return const Center(child: Text('No events joined yet.'));
        }
        return ListView.builder(
          itemCount: dataController.joinedEvents.length,
          itemBuilder: (context, index) {
            final event = dataController.joinedEvents[index];
            return ListTile(
              title: Text(event.get('event_name')),
              subtitle: Text(event.get('date').toString()),
              trailing: ElevatedButton(
                onPressed: () => dataController.generateTicket(event),
                child: const Text('Ticket'),
              ),
            );
          },
        );
      }),
    );
  }
}
