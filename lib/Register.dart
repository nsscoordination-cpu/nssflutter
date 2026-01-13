import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nss/Api/regiapi.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  /// 🎨 SAME COLOR METHOD AS ATTENDANCE PAGE
  final Color primaryColor = const Color(0xFFB4694E);
  final Color lightBg = const Color(0xFFFFF4E6);

  final TextEditingController firstname = TextEditingController();
  final TextEditingController className = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController blood = TextEditingController();
  final TextEditingController interest = TextEditingController();
  final TextEditingController registerYear = TextEditingController();
  final TextEditingController password = TextEditingController();

  String? gender;
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => selectedImage = File(picked.path));
    }
  }

  Future<void> selectDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dob.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB4694E),
              Color(0xFFD8A48F),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 90),
                  child: Column(
                    children: [
                      _profileHeader(),
                      const SizedBox(height: 20),

                      _glassCard(children: [
                        _field(firstname, "Full Name"),
                        _field(className, "Department"),
                        _field(
                          dob,
                          "Date of Birth",
                          readOnly: true,
                          onTap: selectDob,
                        ),
                        _genderSelector(),
                      ]),

                      _glassCard(children: [
                        _rowFields(
                          _field(height, "Height (cm)",
                              keyboardType: TextInputType.number),
                          _field(weight, "Weight (kg)",
                              keyboardType: TextInputType.number),
                        ),
                        _field(blood, "Blood Group"),
                      ]),

                      _glassCard(children: [
                        _field(phoneNo, "Phone Number",
                            keyboardType: TextInputType.number),
                        _field(email, "Email",
                            keyboardType: TextInputType.emailAddress),
                        _field(address, "Address", maxLines: 3),
                      ]),

                      _glassCard(children: [
                        _rowFields(
                          _field(registerYear, "Register Year"),
                          _field(interest, "Interest"),
                        ),
                        _field(password, "Password",
                            obscureText: true),
                      ]),
                    ],
                  ),
                ),

                /// 🔹 STICKY REGISTER BUTTON
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 20,
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        if (selectedImage == null || gender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Please complete all fields"),
                            ),
                          );
                          return;
                        }

                        Registerapi(
                          firstname: firstname.text,
                          department: className.text,
                          dateofbirth: dob.text,
                          Gender: gender!,
                          height: height.text,
                          Weight: weight.text,
                          Address: address.text,
                          phoneno: phoneNo.text,
                          Email: email.text,
                          Blood: blood.text,
                          interest: interest.text,
                          RegisterYear: registerYear.text,
                          Password: password.text,
                          Image: selectedImage!,
                          context: context,
                        );
                      },
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= UI COMPONENTS =================

  Widget _profileHeader() {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: lightBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor.withOpacity(0.2),
              backgroundImage:
                  selectedImage != null ? FileImage(selectedImage!) : null,
              child: selectedImage == null
                  ? Icon(Icons.camera_alt,
                      size: 30, color: primaryColor)
                  : null,
            ),
            const SizedBox(height: 8),
            const Text(
              "Upload Profile Photo",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _rowFields(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 12),
        Expanded(child: right),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    bool obscureText = false,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        obscureText: obscureText,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onTap: onTap,
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.brown),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _genderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceChip(
          label: const Text("Male"),
          selected: gender == "Male",
          selectedColor: primaryColor,
          labelStyle: TextStyle(
            color: gender == "Male"
                ? Colors.white
                : Colors.brown,
          ),
          onSelected: (_) => setState(() => gender = "Male"),
        ),
        ChoiceChip(
          label: const Text("Female"),
          selected: gender == "Female",
          selectedColor: primaryColor,
          labelStyle: TextStyle(
            color: gender == "Female"
                ? Colors.white
                : Colors.brown,
          ),
          onSelected: (_) => setState(() => gender = "Female"),
        ),
      ],
    );
  }
}
