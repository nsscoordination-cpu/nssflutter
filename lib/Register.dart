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
  TextEditingController firstname = TextEditingController();
  TextEditingController className = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController blood = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController RegisterYear = TextEditingController();
  TextEditingController Password = TextEditingController();

  String? Gender;

  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 174, 228),
        title: const Text("REGISTER"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// --------------------------------------
            /// TOP RIGHT IMAGE PICKER
            /// --------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: pickImage,
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: selectedImage == null
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, size: 35, color: Colors.grey),
                                SizedBox(height: 5),
                                Text("Add Photo", style: TextStyle(fontSize: 13)),
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// ----------------------
            /// All Text Fields Below
            /// ----------------------

            _buildField(firstname, "First Name"),
            _buildField(className, "Department"),
            _buildField(dob, "Date of Birth"),

            const SizedBox(height: 5),

            Row(
              children: [
                const Text("Gender:", style: TextStyle(fontSize: 16)),
                Radio(
                  value: "Male",
                  groupValue: Gender,
                  onChanged: (value) => setState(() => Gender = value),
                ),
                const Text("Male"),
                Radio(
                  value: "Female",
                  groupValue: Gender,
                  onChanged: (value) => setState(() => Gender = value),
                ),
                const Text("Female"),
              ],
            ),

            _buildField(height, "Height"),
            _buildField(weight, "Weight"),
            _buildField(address, "Address", maxLines: 3),
            _buildField(phoneNo, "Phone Number"),
            _buildField(email, "Email"),
            _buildField(blood, "Blood Group"),
            _buildField(interest, "Interest"),
            _buildField(RegisterYear, "Register Year"),
            _buildField(Password, "Password", obscureText: true),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (selectedImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select an image")),
                  );
                  return;
                }

                Registerapi(
                  firstname: firstname.text,
                  department: className.text,
                  dateofbirth: dob.text,
                  Gender: Gender ?? "",
                  height: height.text,
                  Weight: weight.text,
                  Address: address.text,
                  phoneno: phoneNo.text,
                  Email: email.text,
                  Blood: blood.text,
                  interest: interest.text,
                  RegisterYear: RegisterYear.text,
                  Password: Password.text,
                  Image: selectedImage!,
                  context: context,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 48, 174, 228),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Register", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom Input Field Builder
  Widget _buildField(TextEditingController controller, String hint,
      {int maxLines = 1, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

