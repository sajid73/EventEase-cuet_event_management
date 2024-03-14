import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/data_controller.dart';
import '../../utils/app_color.dart';

class OnlyProfileScreen extends StatefulWidget {
  const OnlyProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnlyProfileScreenState createState() => _OnlyProfileScreenState();
}

class _OnlyProfileScreenState extends State<OnlyProfileScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userRole = TextEditingController();

  bool isNotEditable = true;

  DataController? dataController;

  String image = '';

  @override
  initState() {
    super.initState();
    dataController = Get.find<DataController>();

    firstNameController.text = dataController!.myDocument!.get('first');
    lastNameController.text = dataController!.myDocument!.get('last');
    userRole.text = dataController!.myDocument!.get('role');

    try {
      descriptionController.text = dataController!.myDocument!.get('desc');
    } catch (e) {
      descriptionController.text = '';
    }

    try {
      image = dataController!.myDocument!.get('image');
    } catch (e) {
      image = '';
    }

    try {
      locationController.text = dataController!.myDocument!.get('location');
    } catch (e) {
      locationController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 100,
                  margin: EdgeInsets.only(
                      left: Get.width * 0.75, top: 20, right: 20),
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Image(
                          image: AssetImage('assets/sms.png'),
                          width: 28,
                          height: 25,
                        ),
                      ),
                      const Image(
                        image: AssetImage('assets/menu.png'),
                        width: 23.33,
                        height: 19,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 90, horizontal: 20),
                  width: Get.width,
                  height: isNotEditable ? 240 : 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(top: 35),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(70),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7DDCFB),
                              Color(0xffBC67F2),
                              Color(0xffACF6AF),
                              Color(0xffF95549),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    image,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    isNotEditable
                        ? Text(
                            "${firstNameController.text} ${lastNameController.text}",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : SizedBox(
                            width: Get.width * 0.6,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: firstNameController,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: 'First Name',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: lastNameController,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      hintText: 'Last Name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    isNotEditable
                        ? Text(
                            locationController.text,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff918F8F),
                            ),
                          )
                        : SizedBox(
                            width: Get.width * 0.6,
                            child: TextField(
                              controller: locationController,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: 'Location',
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    isNotEditable
                        ? SizedBox(
                            width: 270,
                            child: Text(
                              descriptionController.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                letterSpacing: -0.3,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: Get.width * 0.6,
                            child: TextField(
                              controller: descriptionController,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: 'Description',
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 0.01,
                                  ),
                                ),
                              ),
                              child: TabBar(
                                indicatorColor: Colors.black,
                                labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10,
                                ),
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(
                                    icon: Image.asset("assets/ticket.png"),
                                    height: 20,
                                  ),
                                  Tab(
                                    icon: Image.asset("assets/Group 18600.png"),
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: screenheight * 0.46,
                              //height of TabBarView
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: <Widget>[
                                  if (userRole.text == "Organizer")
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          width: 388,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.15),
                                                spreadRadius: 2,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 10),
                                            // Add your content here for the Organizer role
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Center(
                                      child: Text('Tab 1 for Participant'),
                                    ),
                                  if (userRole.text == "Participant")
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          width: 388,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.15),
                                                spreadRadius: 2,
                                                blurRadius: 3,
                                                offset: const Offset(0,
                                                    0), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 10),
                                            // Add your content here for the Participant role
                                          ),
                                        );
                                      },
                                    )
                                  else
                                    const Center(
                                      child: Text('Tab 2 for Organizer'),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 105, right: 35),
                  child: InkWell(
                    onTap: () {
                      if (isNotEditable == false) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'first': firstNameController.text,
                          'last': lastNameController.text,
                          'location': locationController.text,
                          'desc': descriptionController.text
                        }, SetOptions(merge: true)).then((value) {
                          Get.snackbar('Profile Updated',
                              'Profile has been updated successfully.',
                              colorText: Colors.white,
                              backgroundColor: Colors.blue);
                        });
                      }

                      setState(() {
                        isNotEditable = !isNotEditable;
                      });
                    },
                    child: isNotEditable
                        ? Image(
                            image: const AssetImage('assets/edit.png'),
                            width: screenwidth * 0.04,
                          )
                        : const Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
