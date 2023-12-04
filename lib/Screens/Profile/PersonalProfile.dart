import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:believeder_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:believeder_app/repositories/UserRepo.dart';
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:believeder_app/Screens/Profile/Widgets/InfoTextBox.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
import 'package:believeder_app/Screens/Profile/Widgets/editDataProfile.dart';
import 'package:believeder_app/Screens/Profile/cubit/avatarCubit/cubit/avatar_cubit.dart';
import 'package:believeder_app/Screens/Profile/cubit/editInfoCubit/cubit/edit_info_cubit.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  File? image;
  String _selectedGender = "None"; // Default selection
  List<String> _genderOptions = ['Male', 'Female', 'Email'];
  //DateTime dateTime = DateTime.now();

  DateRangePickerController _dateRangePickerController =
      DateRangePickerController();

  TextEditingController Gender = TextEditingController();
  TextEditingController bDay = TextEditingController();

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
                kPrimaryLightColor,
                kPrimaryLightColor,
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
                        height: MediaQuery.sizeOf(context).height / 3.4,
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
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY:
                                  5.0), // Độ mờ: điều chỉnh giá trị của sigmaX và sigmaY
                          child: Container(
                            color: Colors.black.withOpacity(
                                0.3), // Màu và độ mờ của hiệu ứng làm mờ
                          ),
                        ),
                      ),
                      ListView(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                left: 10.0,
                                right: 10.0
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,                             
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: TextButton.icon(
                                      label: Text(
                                        'Edit Avatar',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () => _showImagePickerModal(
                                      context, state.user.userId
                                      ),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )
                                    ),
                                  ), 
                                ],
                              ),
                            ),
                          ), 
                          const SizedBox(
                            height: 50.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 50.0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 1,
                                    width: size.width * 0.952,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20.0,
                                      ),
                                      child: Container(
                                        width: 120.0, // Đặt chiều rộng và chiều cao cho container
                                        height: 120.0,
                                        decoration: BoxDecoration(
                                          color: kPrimaryLightColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white, // Màu sắc của border
                                            width: 10.0, // Độ rộng của border (1px)
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors
                                              .transparent, // Optional: Set background color to transparent
                                          child: ClipOval(
                                            child: Image.network(
                                              imgUrl,
                                              width:
                                                  100, // Set the width to the double of the radius
                                              height:
                                                  100, // Set the height to the double of the radius
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 40.0
                                      ),
                                      child: Text(
                                        state.user.lastName + " " + state.user.firstName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                    
                              ],
                            ),
                          ),              
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10.0 , 0 , 10.0, 10.0),
                            child: Expanded(
                              child: Container(
                                // height: MediaQuery.of(context).size.height * 0.9,
                                // width: MediaQuery.of(context).size.width / 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: BlocBuilder<EditInfoCubit, EditInfoState>(
                                  builder: (context, editState) {
                                    if (editState is EditInfoSuccess) {
                                      BlocProvider.of<LoginCubit>(context)
                                          .reGetUser();
                                    }
                                    return Column(
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
                                                color: Colors.black,
                                                fontSize: 15.0),
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
                                              BlocProvider.of<EditInfoCubit>(
                                                      context)
                                                  .updateBio(updatedBio, Info.bio,
                                                      state.user);
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
                                            String updatedlastName =
                                                await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return EditProfileDialog(
                                                  text: "Change last Name",
                                                );
                                              },
                                            );
                                            if (updatedlastName != '') {
                                              print(
                                                  'Updated Bio: $updatedlastName');
                                              BlocProvider.of<EditInfoCubit>(
                                                      context)
                                                  .updateInfo(updatedlastName,
                                                      Info.lname, state.user);
                                            }
                                          },
                                        ),
                                        infoTextBox(
                                          text: state.user.firstName,
                                          sectionName: 'First Name',
                                          onTap: () async {
                                            String updatedFirstName =
                                                await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return EditProfileDialog(
                                                  text: "Change First Name",
                                                );
                                              },
                                            );
                                            if (updatedFirstName != '') {
                                              print(
                                                  'Updated Bio: $updatedFirstName');
                                              BlocProvider.of<EditInfoCubit>(
                                                      context)
                                                  .updateInfo(updatedFirstName,
                                                      Info.fname, state.user);
                                            }
                                          },
                                        ),
                                        infoTextBox(
                                          text: state.user.birthDay,
                                          sectionName: 'Birthday',
                                          onTap: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    SfDateRangePicker(
                                                      controller:
                                                          _dateRangePickerController,
                                                      backgroundColor:
                                                          Colors.white,
                                                      view: DateRangePickerView
                                                          .month,
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .single,
                                                      toggleDaySelection: true,
                                                      showActionButtons: true,
                                                      showNavigationArrow: true,
                                                      onCancel: () {
                                                        _dateRangePickerController
                                                            .selectedDate = null;
                                                        Navigator.pop(context);
                                                      },
                                                      onSubmit:
                                                          (Object? value) async {
                                                        print(value);
                                                        await BlocProvider.of<
                                                                    EditInfoCubit>(
                                                                context)
                                                            .updateInfo(
                                                              value.toString(),
                                                              Info.bday,
                                                              state.user,
                                                            )
                                                            .then((value) =>
                                                                Navigator.pop(
                                                                    context));
                                                      },
                                                    ));
                                          },
                                        ),
                                        infoTextBox(
                                            text: state.user.gender,
                                            sectionName: 'Gender',
                                            onTap: () async {
                                              await showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Cancel')),
                                                    TextButton(
                                                        onPressed: () async {
                                                          await BlocProvider.of<
                                                                      EditInfoCubit>(
                                                                  context)
                                                              .updateInfo(
                                                                _selectedGender,
                                                                Info.gender,
                                                                state.user,
                                                              )
                                                              .then((value) =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                        child: Text('Change')),
                                                  ],
                                                  content: SizedBox(
                                                    // width: double.infinity,
                                                    height: 100,
                                                    child: CupertinoPicker(
                                                      itemExtent: 30,
                                                      scrollController:
                                                          FixedExtentScrollController(
                                                        initialItem:
                                                            _genderOptions.indexOf(
                                                                _selectedGender),
                                                      ),
                                                      children: _genderOptions
                                                          .map((gender) =>
                                                              Text(gender))
                                                          .toList(),
                                                      onSelectedItemChanged:
                                                          (int index) {
                                                        _selectedGender =
                                                            _genderOptions[index];
                                                        Gender.text =
                                                            _selectedGender;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                        infoTextBox(
                                          text: state.user.location,
                                          sectionName: 'Location',
                                          onTap: () async {
                                            String updatedLocation =
                                                await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return EditProfileDialog(
                                                  text: "Change Location",
                                                );
                                              },
                                            );
                                            if (updatedLocation != '') {
                                              print(
                                                  'Updated Bio: $updatedLocation');
                                              BlocProvider.of<EditInfoCubit>(
                                                      context)
                                                  .updateInfo(updatedLocation,
                                                      Info.location, state.user);
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  // Navigator.pop(context);
                                  await BlocProvider.of<LoginCubit>(context)
                                      .logout()
                                      .then((value) =>
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/welcome',
                                            (route) => false,
                                          ));
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
              child = Center(child: const Text('No Image Choose'));
            }
            return Container(
              height: 300,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: child,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: kPrimaryColor,
                            )
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                          ),
                          child: Center(
                            child: Text (
                              'Change Avatar',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                                                    ),
                          )),
                      ),
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
