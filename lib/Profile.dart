import 'package:flutter/material.dart';
import 'package:nss/Api/loginapi.dart';
import 'package:nss/Api/regiapi.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic> profile = [];

  /// Controllers
  TextEditingController firstname = TextEditingController();
  TextEditingController className = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController blood = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController sex = TextEditingController();

  /// Fetch Profile
  Future<void> get_profile() async {
    try {
      final response = await dio.get('$url/api/student/profile/$Loginid');
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          profile = response.data['profile'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  /// Update Profile
  Future<void> updateProfile() async {
    try {
      final response = await dio.put(
        '$url/api/student/profile/$Loginid',
        data: {
          "name": firstname.text,
          "className": className.text,
          "dob": dob.text,
          "sex": sex.text,
          "height": height.text,
          "weight": weight.text,
          "address": address.text,
          "phone": phoneNo.text,
          "blood": blood.text,
          "interests": interest.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
        get_profile();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully")),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Update failed")),
      );
    }
  }

  /// Edit Dialog
  void editprofile() {
    firstname.text = profile[0]['name'] ?? '';
    className.text = profile[0]['className'] ?? '';
    dob.text = profile[0]['dob'] ?? '';
    sex.text = profile[0]['sex'] ?? '';
    height.text = profile[0]['height'] ?? '';
    weight.text = profile[0]['weight'] ?? '';
    address.text = profile[0]['address'] ?? '';
    phoneNo.text = profile[0]['phone'] ?? '';
    blood.text = profile[0]['blood'] ?? '';
    interest.text = profile[0]['interests'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFF4E6), // Warm beige dialog
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Color(0xFFB4694E)), // Warm brown
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                buildField("Name", firstname, Icons.person),
                buildField("Class", className, Icons.school_outlined),
                buildField("DOB", dob, Icons.cake_outlined),
                buildField("Sex", sex, Icons.female),
                buildField("Height", height, Icons.height),
                buildField("Weight", weight, Icons.monitor_weight_outlined),
                buildField("Address", address, Icons.location_on),
                buildField("Phone", phoneNo, Icons.phone),

                /// Read-only Email
                TextFormField(
                  initialValue: profile[0]['email'],
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Color(0xFFFFE8D6), // light cream
                    prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFB4694E)),
                    labelStyle: TextStyle(color: Color(0xFFB4694E)), // Warm brown heading
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                buildField("Blood Group", blood, Icons.bloodtype_outlined),
                buildField("Interests", interest, Icons.interests),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB4694E), // warm brown button
                  ),
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Reusable TextField
  Widget buildField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFFFE8D6), // Light cream
          prefixIcon: Icon(icon, color: Color(0xFFB4694E)), // Warm brown
          labelStyle: TextStyle(color: Color(0xFFB4694E)), // Warm brown heading
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    get_profile();
  }

  @override
  Widget build(BuildContext context) {
    if (profile.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile Details"),
          backgroundColor: Color(0xFFB4694E),
        ),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFB4694E))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Details"),
        centerTitle: true,
        backgroundColor: Color(0xFFB4694E), // Warm brown
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF4E6), // Warm beige top
              Color(0xFFFFE8D6), // Light cream bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  '$url/uploads/students/${profile[0]['photo']}',
                ),
              ),
              SizedBox(height: 16),
              Text(
                profile[0]['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB4694E), // Warm brown
                ),
              ),
              Divider(height: 40, color: Color(0xFFB4694E)),

              infoTile(Icons.email, "Email", profile[0]['email']),
              infoTile(Icons.school_outlined, "Class", profile[0]['className']),
              infoTile(Icons.phone, "Phone", profile[0]['phone']),
              infoTile(Icons.cake, "DOB", profile[0]['dob']),
              infoTile(Icons.female, "Sex", profile[0]['sex']),
              infoTile(Icons.height, "Height", profile[0]['height']),
              infoTile(Icons.monitor_weight, "Weight", profile[0]['weight']),
              infoTile(Icons.location_on, "Address", profile[0]['address']),
              infoTile(Icons.bloodtype, "Blood", profile[0]['blood']),
              infoTile(Icons.interests, "Interests", profile[0]['interests']),

              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: editprofile,
                icon: Icon(Icons.edit),
                label: Text("Edit Profile"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB4694E),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoTile(IconData icon, String title, String value) {
    return Card(
      color: Color(0xFFFFE8D6), // Light cream background
      child: ListTile(
        leading: Icon(icon, color: Color(0xFFB4694E)), // Warm brown icon
        title: Text(title, style: TextStyle(color: Color(0xFFB4694E))), // Warm brown heading
        subtitle: Text(value, style: TextStyle(color: Colors.brown.shade700)),
      ),
    );
  }
}
