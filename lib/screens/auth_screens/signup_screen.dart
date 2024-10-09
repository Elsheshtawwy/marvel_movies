
import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';
import 'package:marvel/providers/auth_provider.dart';
import 'package:marvel/widgets/buttons/main_button.dart';
import 'package:marvel/widgets/custome_text_form_filde.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController genderController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController PhoneController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up  Screen"),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 70),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/marvelLogo.png"),
                const SizedBox(
                  height: 40,
                ),
                CustomeTextFormFiled(
                    label: "name",
                    textEditingController: nameController,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "name cant be empty ";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 25,
                ),
                CustomeTextFormFiled(
                    label: "phone",
                    textEditingController: PhoneController,
                    validate: (v) {
                      if (v!.length != 10) {
                        return " phone must be 10 numers ";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 25,
                ),
                CustomeTextFormFiled(
                    label: "password",
                    textEditingController: passwordController,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "password is requred ";
                      }
                      if (v.length < 8) {
                        return "password must be at least 8 characters long ";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField<String>(
                  value: genderController.text.isEmpty ? null : genderController.text,
                  decoration: InputDecoration(labelText: "Gender"),
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      genderController.text = newValue!;
                    });
                  },
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Gender is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    hintText: 'yyyy-mm-dd',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Date of Birth is required";
                    }
                    // Simple regex for date validation
                    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(v)) {
                      return "Please enter a valid date in yyyy-mm-dd format";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: MainButton(
                    text: "SignUp",
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false).signup({
                        "name": nameController.text,
                        "phone": PhoneController.text,
                        "password": passwordController.text,
                        "gender": genderController.text,
                        "DOB": dateController.text
                      }).then((onValue) {
                        if (onValue) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    borderRadius: 10,
                    btnColor: mainColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
