import 'dart:convert';
import 'dart:io';

import 'package:contacts_app/gen/assets.gen.dart';
import 'package:contacts_app/theme/color_resources.dart';
import 'package:contacts_app/utils/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage(
      {super.key, required this.icon, this.dbImage, this.onChanged});
  final String icon;
  final String? dbImage;
  final void Function(String text)? onChanged;
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  Future<void> pickimageandConvert(File file) async {
    try {
      // if (file != null && file.files.isNotEmpty) {
      // Read the PDF file as bytes
      final bytes = File(file.path!).readAsBytesSync();

      // Convert the bytes to base64
      String file64 = base64Encode(bytes);

      // Prepend the necessary data URL header with MIME type
      String dataUrl = 'data:image/jpeg;base64,$file64';

      // Use dataUrl as needed (e.g., display in WebView, send to server, etc.)
      widget.onChanged?.call(dataUrl ?? "");
      print('Data URL: $dataUrl');
      // }
    } catch (e) {
      print('Base64 Error picking or converting PDF: $e');
    }
  }

  File? croppedProfileImage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            croppedProfileImage != null
                ? Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 5, color: ColorResources.WHITE),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(croppedProfileImage!),
                          // CachedNetworkImage(
                          //     'https://images.pexels.com/photos/3936894/pexels-photo-3936894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')
                        )),
                  )

                // CircleAvatar(
                //     radius: 66,
                //     backgroundImage: FileImage(croppedProfileImage!),
                //   )

                : (widget.dbImage != null && widget.dbImage != '')
                    ? Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            color: ColorResources.GREY5,
                            border: Border.all(
                                width: 5, color: ColorResources.GREY4),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.dbImage ?? '')
                                // image:
                                //  widget.dbImage == null
                                //     ? NetworkImage('widget.dbImage')
                                //     :
                                //     CachedNetworkImageProvider(
                                //         widget.dbImage ??
                                //             'https://images.pexels.com/photos/3936894/pexels-photo-3936894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                //         errorListener: (error) {
                                //   print(error);
                                // })
                                // CachedNetworkImage(
                                //     'https://images.pexels.com/photos/3936894/pexels-photo-3936894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')
                                )),
                      )
                    : Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            color: ColorResources.GREY5,
                            border: Border.all(
                                width: 5, color: ColorResources.tabBarGrey),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (userLocalData == null ||
                                        userLocalData!.isEmpty)
                                    ? AssetImage(
                                            Assets.icon.profilePicDummy.keyName)
                                        as ImageProvider<Object>
                                    : NetworkImage(userLocalData ?? '')

                                // image:
                                //  widget.dbImage == null
                                //     ? NetworkImage('widget.dbImage')
                                //     :
                                //     CachedNetworkImageProvider(
                                //         widget.dbImage ??
                                //             'https://images.pexels.com/photos/3936894/pexels-photo-3936894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                //         errorListener: (error) {
                                //   print(error);
                                // })
                                // CachedNetworkImage(
                                //     'https://images.pexels.com/photos/3936894/pexels-photo-3936894.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2')
                                )),
                      ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 1,
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, boxShadow: []),
                child: CupertinoButton(
                  pressedOpacity: 0.7,
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    final result = await FilePickerService()
                        .showImageSourceBottomSheet(context);
                    if (result == null) {
                      return;
                    }

                    croppedProfileImage = await FilePickerService()
                        .pickImage(imageSource: result);
                    if (croppedProfileImage != null) {
                      pickimageandConvert(croppedProfileImage!);
                    }
                    if (mounted) {
                      setState(() {});
                    }
                    // setState(() {});
                  },
                  child: Material(
                      surfaceTintColor: Colors.white,
                      elevation: 3,
                      shadowColor: ColorResources.GREY4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      child: SvgPicture.asset(widget.icon)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String userLocalData = '';
//'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmale-profile&psig=AOvVaw2s4S-q-Z_X4wnvBcPs8V1e&ust=1708016987142000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCIjZ4KCpq4QDFQAAAAAdAAAAABAE';