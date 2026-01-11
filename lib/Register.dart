// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nss/Api/regiapi.dart';

// class RegisterForm extends StatefulWidget {
//   const RegisterForm({super.key});

//   @override
//   State<RegisterForm> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<RegisterForm> {
//   TextEditingController firstname = TextEditingController();
//   TextEditingController className = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController height = TextEditingController();
//   TextEditingController weight = TextEditingController();
//   TextEditingController address = TextEditingController();
//   TextEditingController phoneNo = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController blood = TextEditingController();
//   TextEditingController interest = TextEditingController();
//   TextEditingController RegisterYear = TextEditingController();
//   TextEditingController Password = TextEditingController();

//   String? Gender;

//   File? selectedImage;
//   final ImagePicker picker = ImagePicker();

//   Future pickImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         selectedImage = File(picked.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 48, 174, 228),
//         title: const Text("REGISTER"),
//         centerTitle: true,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             /// --------------------------------------
//             /// TOP RIGHT IMAGE PICKER
//             /// --------------------------------------
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap: pickImage,
//                   child: Container(
//                     height: 130,
//                     width: 130,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey),
//                     ),
//                     child: selectedImage == null
//                         ? const Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.camera_alt, size: 35, color: Colors.grey),
//                                 SizedBox(height: 5),
//                                 Text("Add Photo", style: TextStyle(fontSize: 13)),
//                               ],
//                             ),
//                           )
//                         : ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.file(
//                               selectedImage!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 15),

//             /// ----------------------
//             /// All Text Fields Below
//             /// ----------------------

//             _buildField(firstname, "First Name"),
//             _buildField(className, "Department"),
//             _buildField(dob, "Date of Birth"),

//             const SizedBox(height: 5),

//             Row(
//               children: [
//                 const Text("Gender:", style: TextStyle(fontSize: 16)),
//                 Radio(
//                   value: "Male",
//                   groupValue: Gender,
//                   onChanged: (value) => setState(() => Gender = value),
//                 ),
//                 const Text("Male"),
//                 Radio(
//                   value: "Female",
//                   groupValue: Gender,
//                   onChanged: (value) => setState(() => Gender = value),
//                 ),
//                 const Text("Female"),
//               ],
//             ),

//             _buildField(height, "Height"),
//             _buildField(weight, "Weight"),
//             _buildField(address, "Address", maxLines: 3),
//             _buildField(phoneNo, "Phone Number"),
//             _buildField(email, "Email"),
//             _buildField(blood, "Blood Group"),
//             _buildField(interest, "Interest"),
//             _buildField(RegisterYear, "Register Year"),
//             _buildField(Password, "Password", obscureText: true),

//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () {
//                 if (selectedImage == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Please select an image")),
//                   );
//                   return;
//                 }

//                 Registerapi(
//                   firstname: firstname.text,
//                   department: className.text,
//                   dateofbirth: dob.text,
//                   Gender: Gender ?? "",
//                   height: height.text,
//                   Weight: weight.text,
//                   Address: address.text,
//                   phoneno: phoneNo.text,
//                   Email: email.text,
//                   Blood: blood.text,
//                   interest: interest.text,
//                   RegisterYear: RegisterYear.text,
//                   Password: Password.text,
//                   Image: selectedImage!,
//                   context: context,
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 48, 174, 228),
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text("Register", style: TextStyle(fontSize: 18)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Custom Input Field Builder
//   Widget _buildField(TextEditingController controller, String hint,
//       {int maxLines = 1, bool obscureText = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           hintText: hint,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//     );
//   }
// }




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
  final Color primaryColor = const Color(0xFF1565C0);

  final _formKey = GlobalKey<FormState>();

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
      setState(() {
        selectedImage = File(picked.path);
      });
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Create Account"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Image
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage:
                      selectedImage != null ? FileImage(selectedImage!) : null,
                  child: selectedImage == null
                      ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              _cardSection(
                title: "Personal Information",
                children: [
                  _field(firstname, "Full Name", Icons.person),
                  _field(className, "Department", Icons.school),
                  _field(
                    dob,
                    "Date of Birth",
                    Icons.calendar_today,
                    readOnly: true,
                    onTap: selectDob,
                  ),
                  const SizedBox(height: 10),
                  _genderSelector(),
                ],
              ),

              _cardSection(
                title: "Physical Details",
                children: [
                  _field(height, "Height (cm)", Icons.height),
                  _field(weight, "Weight (kg)", Icons.monitor_weight),
                  _field(blood, "Blood Group", Icons.bloodtype),
                ],
              ),

              _cardSection(
                title: "Contact Information",
                children: [
                  _field(phoneNo, "Phone Number", Icons.phone,
                      keyboardType: TextInputType.phone),
                  _field(email, "Email", Icons.email,
                      keyboardType: TextInputType.emailAddress),
                  _field(address, "Address", Icons.location_on, maxLines: 3),
                ],
              ),

              _cardSection(
                title: "Account Details",
                children: [
                  _field(registerYear, "Register Year", Icons.date_range),
                  _field(interest, "Interests", Icons.star),
                  _field(password, "Password", Icons.lock,
                      obscureText: true),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    if (selectedImage == null || gender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please complete all fields")),
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
                    "Register",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🧩 Card Section
  Widget _cardSection({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  // 🧩 Input Field
  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
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
        validator: (value) =>
            value == null || value.isEmpty ? "Required field" : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // 🧩 Gender Selector
  Widget _genderSelector() {
    return Row(
      children: [
        ChoiceChip(
          label: const Text("Male"),
          selected: gender == "Male",
          onSelected: (_) => setState(() => gender = "Male"),
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text("Female"),
          selected: gender == "Female",
          onSelected: (_) => setState(() => gender = "Female"),
        ),
      ],
    );
  }
}

