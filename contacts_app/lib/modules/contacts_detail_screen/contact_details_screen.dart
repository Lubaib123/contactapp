import 'package:contacts_app/controller/provider.dart';
import 'package:contacts_app/gen/assets.gen.dart';
import 'package:contacts_app/services/firestore.dart';
import 'package:contacts_app/theme/dimensions.dart';
import 'package:contacts_app/theme/text_style.dart';
import 'package:contacts_app/utils/text_field.dart';
import 'package:contacts_app/widgets/profile_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen(
      {super.key, this.docId, this.name, this.image, this.phoneNumber});
  final String? docId;
  final String? name;
  final String? phoneNumber;
  final String? image;
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String? _validatePhone(String? value) {
    return value!.isEmpty
        ? "Phone is required"
        : value.length < 7
            ? "Please enter a valid number"
            : null;
  }

  final phoneController = TextEditingController();
  final numberController = TextEditingController();
  final mobileController = TextEditingController();
  final namedctlr = TextEditingController();
  final profileImage = TextEditingController();

  final FireStoreService fireStoreService = FireStoreService();

  final contactkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    forUpdateData();
    super.initState();
  }

  forUpdateData() {
    if (widget.docId != null) {
      // numberController.text == widget.phoneNumber ?? "";
      namedctlr.text = widget.name ?? "";
      mobileController.text = widget.phoneNumber ?? "";

      //numberController.text == widget.phoneNumber ?? "";
      profileImage.text == widget.image ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactAppProvider>(builder: (context, controller, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.docId != null ? "Edit" : 'Create'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: contactkey,
              child: Column(
                children: [
                  gapLarge,
                  ProfileImage(
                    icon: Assets.icon.editprofileCameraDarkIcon,
                    onChanged: (text) => profileImage.text,
                  ),
                  gapLarge,
                  TextFieldCustom(
                    controller: namedctlr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: "Name",
                    hintText: "Enter Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Name';
                      }
                    },
                  ),
                  gapLarge,
                  gapLarge,
                  TextFieldCustom(
                    controller: mobileController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    labelText: "Phone Number",
                    hintText: "Enter Phone Number",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Your Mobile Number";
                      } else if (value.length < 10) {
                        return "Please enter Your 10 digit Mobile Number";
                      }
                      return null;
                    },
                    onChanged: (text) {
                      if (text.length >= 10) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),

                  // TextFieldCustom(
                  //   controller: phoneController,
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   // focusNode: perctangeFocusNode,
                  //   maxLength: 10,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Please enter Your Mobile Number";
                  //     } else if (value.length < 10) {
                  //       return "Please enter Your 10 digit Mobile Number";
                  //     }
                  //     return null;
                  //   },
                  //   onChanged: (text) {
                  //     if (text.length >= 10) {
                  //       FocusScope.of(context).unfocus();
                  //     }
                  //   },
                  //   labelText: "Phone Number",
                  // keyboardType: TextInputType.phone,
                  // textInputAction: TextInputAction.done,
                  //   hintText: 'Add Phone Number',
                  //   prefixWidget: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       CountryCodePicker(
                  //         showCountryOnly: true,
                  //         dialogTextStyle: body1.grey1,
                  //         onChanged: controller.onCountryChanged,
                  //         initialSelection: controller.selectedCountry.name,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //  gapLarge,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SubmitButton.primary(
              widget.docId != null ? 'Update' : "Save",
              onTap: (value) {
                if (contactkey.currentState!.validate()) {
                  widget.docId == null
                      ? addfunction(context)
                      : updateFunction(context);

                  HapticFeedback.selectionClick();
                } else {
                  HapticFeedback.heavyImpact();
                }
              },
            ),
          ),
        ),
      );
    });
  }

  updateFunction(BuildContext context) {
    //print(mobileController.text);
    fireStoreService.updatecontact(
      widget.docId ?? '',
      namedctlr.text,
      mobileController.text,
      "+91",
      widget.image ??
          "https://cdn0.iconfinder.com/data/icons/social-messaging-ui-color-shapes/128/phone-circle-green-512.png",
    );
    Navigator.pop(context);
  }

  addfunction(BuildContext context) {
    print(profileImage.text);
    fireStoreService.addingContacts(
        namedctlr.text,
        mobileController.text,
        "+91",
        (profileImage.text != "")
            ? profileImage.text
            : "https://cdn0.iconfinder.com/data/icons/social-messaging-ui-color-shapes/128/phone-circle-green-512.png");
    Navigator.pop(context);
  }
}
