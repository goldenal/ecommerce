import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editprofile extends StatelessWidget {
  Editprofile({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _homecontrol = Get.put(HomeController());
    final TextEditingController _emailTEController =
        TextEditingController(text: _homecontrol.phone);
    final TextEditingController _addrController =
        TextEditingController(text: _homecontrol.address);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Cannot be empty";
                  } else {
                    return null;
                  }
                },
                controller: _emailTEController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "cannot be empty";
                  } else {
                    return null;
                  }
                },
                controller: _addrController,
                decoration:
                    const InputDecoration(labelText: "Shipping Address"),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<HomeController>(builder: (ct) {
                  if (ct.editing) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _homecontrol.editProfile(
                            _emailTEController.text, _addrController.text);
                      }
                    },
                    child: const Text("Edit profile"),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
