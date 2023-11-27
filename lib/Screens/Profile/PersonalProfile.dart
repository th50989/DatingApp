import 'dart:io';

import 'package:believeder_app/Screens/Profile/cubit/avatarCubit/cubit/avatar_cubit.dart';
import 'package:believeder_app/repositories/UserRepo.dart';
import 'package:flutter/material.dart';
import 'package:believeder_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:believeder_app/Screens/Profile/Widgets/InfoTextBox.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';

import 'package:image_picker/image_picker.dart';

import 'package:believeder_app/Screens/Profile/Widgets/editDataProfile.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  File? image;

  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context).reGetUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width * 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(241, 230, 255, 1),
                Colors.white70,
              ]),
        ),
        height: size.height,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginSuccess) {
              return BlocBuilder<AvatarCubit, AvatarState>(
                builder: (context, avtState) {
                  if (avtState is AvatarUploadSuccess) {
                    BlocProvider.of<LoginCubit>(context).reGetUser();
                  }
                  var imgUrl = state.user.imgUrl;
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.sizeOf(context).height / 2.6,
                        decoration: BoxDecoration(
                          image: imgUrl != ''
                              ? DecorationImage(
                                  image: NetworkImage(imgUrl),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/defaul_background.jpg"),
                                  fit: BoxFit.cover,
                                ),
                          color: imgUrl != null
                              ? null
                              : Colors.grey, // Màu nền của hộp trang trí
                          borderRadius:
                              BorderRadius.circular(10.0), // Góc bo tròn
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Màu đổ bóng
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // Vị trí đổ bóng
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        children: [
                          const SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width:
                                120.0, // Đặt chiều rộng và chiều cao cho container
                            height: 120.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black, // Màu sắc của border
                                width: 1.0, // Độ rộng của border (1px)
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                imgUrl,
                              ),
                            ),
                          ),
                          TextButton.icon(
                              label: Text('Edit Avatar'),
                              onPressed: () => _showImagePickerModal(
                                  context, state.user.userId),
                              icon: const Icon(Icons.edit)),
                          Text(
                            state.user.lastName + " " + state.user.firstName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.9,
                              width: MediaQuery.of(context).size.width / 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                    )
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.0,
                                      left: 25.0,
                                      bottom: 5.0,
                                    ),
                                    child: Text(
                                      'My Details',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.0),
                                    ),
                                  ),
                                  infoTextBox(
                                    text: state.user.bio,
                                    sectionName: 'Bio',
                                    onTap: () async {
                                      String updatedBio = await showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditProfileDialog(
                                            text: "Change Bio",
                                          );
                                        },
                                      );
                                      if (updatedBio != '') {
                                        print('Updated Bio: $updatedBio');
                                      } else {
                                        print(
                                            'User canceled the operation or did not enter a value.');
                                      }
                                    },
                                  ),
                                  infoTextBox(
                                    text: state.user.lastName,
                                    sectionName: 'Last Name',
                                    onTap: () async {
                                      String updatelastName = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditProfileDialog(
                                            text: "Change last Name",
                                          );
                                        },
                                      );
                                      if (updatelastName != '') {
                                        print('Updated Bio: $updatelastName');
                                      }
                                    },
                                  ),
                                  infoTextBox(
                                    text: state.user.firstName,
                                    sectionName: 'First Name',
                                    onTap: () {},
                                  ),
                                  infoTextBox(
                                    text: state.user.birthDay,
                                    sectionName: 'Birthday',
                                    onTap: () {},
                                  ),
                                  infoTextBox(
                                    text: state.user.gender,
                                    sectionName: 'Gender',
                                    onTap: () {},
                                  ),
                                  infoTextBox(
                                    text: state.user.location,
                                    sectionName: 'Location',
                                    onTap: () {},
                                  ),
                                  infoTextBox(
                                    text: state.user.age.toString(),
                                    sectionName: 'Age',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.pop(context);
                                  context.read<LoginCubit>().logout();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()),
                                    (route) => false,
                                  );
                                },
                                child: const Text(
                                    style: TextStyle(color: Colors.white),
                                    'L O G O U T')),
                          )
                        ],
                      ),
                    ],
                  );
                },
              );
            } else {
              return const WelcomeScreen();
            }
          },
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      BlocProvider.of<AvatarCubit>(context).selectImage(image!);
    }
  }

  Future<void> _showImagePickerModal(BuildContext context, int userId) async {
    BlocProvider.of<AvatarCubit>(context).emit(AvatarSelectFailed());
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        Widget child = const Text('No Image Choose');
        return BlocBuilder<AvatarCubit, AvatarState>(
          builder: (context, state) {
            if (state is AvatarSelectSuccess) {
              child = Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(image: FileImage(state.image))),
              );
            } else if (state is AvatarSelectFailed) {
              child = const Text('No Image Choose');
            }
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 200,
                        child: child,
                      ),
                      Container(
                        width: 100,
                        child: TextButton(
                          onPressed: () async {
                            await _pickImage(context);
                            //Navigator.pop(context); // Đóng bottom sheet khi đã chọn ảnh
                          },
                          child: Text('Pick Avatar'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () async {
                        if (image != null) {
                          await BlocProvider.of<AvatarCubit>(context)
                              .uploadImage(userId, image!)
                              .then((value) {
                            image = null;
                            Navigator.pop(context);
                          });
                          // Đóng bottom sheet khi đã chọn ảnh
                        } else {
                          print('No image choose');
                        }
                      },
                      child: Text('Change Avatar'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
