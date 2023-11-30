import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../Models/Model_SQL.dart';

class Resume_Details extends StatefulWidget {
  @override
  State<Resume_Details> createState() => _Resume_DetailsState();
}

class _Resume_DetailsState extends State<Resume_Details> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String isresult = "";
  int? dataid;

  String _name = '';
  String? _dob = '';
  String _email = '';
  String _mobileNumber = '';
  String _skills = '';
  String _hob = '';
  String _projectdetalis = '';
  String _linkdin = "";
  String _educationdetalis = '';

  TextEditingController _namecont = TextEditingController();
  TextEditingController _emailcont = TextEditingController();
  TextEditingController _mobilecont = TextEditingController();
  TextEditingController _skillscont = TextEditingController();
  TextEditingController _projectdetaliscont = TextEditingController();
  TextEditingController _dobcont = TextEditingController();
  TextEditingController _hobb = TextEditingController();
  TextEditingController _linkdincont = TextEditingController();
  TextEditingController _educationdetaliscont = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      dataid = arguments['id'] ?? '';
      _namecont.text = arguments['name'] ?? '';
      _dobcont.text = arguments['dob'] ?? '';
      _emailcont.text = arguments['email'] ?? '';
      _mobilecont.text = arguments['mobileNumber'] ?? '';
      _skillscont.text = arguments['skills'] ?? '';
      _projectdetaliscont.text = arguments['projectdetalis'] ?? '';
      _hobb.text = arguments['hob'] ?? '';
      _linkdincont.text = arguments['linked'] ?? '';
      _educationdetaliscont.text = arguments['educationdetalis'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(dataid == null ? 'New Resume' : 'Edit Resume',
            style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Enter Name :", style: TextStyle(fontSize: 20)),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Name',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                controller: _namecont,
              ),
              const SizedBox(height: 16.0),
              const Text("Date of Birth :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      String formattedDate =
                          DateFormat('dd.MM.yy').format(picked);
                      _dob = formattedDate;
                      _dobcont.text = _dob!;
                    });
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'DoB',
                      suffixIcon: Icon(Icons.calendar_month_sharp,
                      color: Colors.orange,),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87,)
                        )
                    ),
                    controller: _dobcont,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text("Email :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Email',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )),
                validator: (value) {
                  final pattern = r'^[\w.-]+@gmail.com$';
                  final regExp = RegExp(pattern);

                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!regExp.hasMatch(value)) {
                    return 'Enter valid Email';
                  }

                  return null;
                },
                controller: _emailcont,
              ),
              const SizedBox(height: 16.0),
              const Text("Mobile Number :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: 'Mobile Number', counterText: "",
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
                controller: _mobilecont,
              ),
              const SizedBox(height: 16.0),
              const Text("Education detalis :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                const InputDecoration(labelText: 'Education detalis',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Education detalis';
                  }
                  return null;
                },
                controller: _educationdetaliscont,
              ),
              const SizedBox(height: 16.0),
              const Text("Skills :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Skills',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87,)
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Skills';
                  }
                  return null;
                },
                controller: _skillscont,
              ),
              const SizedBox(height: 16.0),
              const Text("Project Detalis :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'projectdetalis',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your project detalis';
                  }
                  return null;
                },
                controller: _projectdetaliscont,
              ),
              const SizedBox(height: 16.0),
              const Text("Hobbies :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Hobbies',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hobbies';
                  }
                  return null;
                },
                controller: _hobb,
              ),
              const SizedBox(height: 16.0),
              const Text("Linkdin link  :", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16.0),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'LinkdIn',
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87,)
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Linkedin';
                  }
                  return null;
                },
                controller: _linkdincont,
              ),

              const SizedBox(height: 16.0),
              InkWell(
                child: Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                      child: Text(
                    dataid == null ? 'Save' : 'Edit',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (dataid == null || dataid == "") {
                      _name = _namecont.text;
                      _dob = _dobcont.text;
                      _email = _emailcont.text;
                      _mobileNumber = _mobilecont.text;
                      _skills = _skillscont.text;
                      _hob = _hobb.text;
                      _projectdetalis = _projectdetaliscont.text;
                      _linkdin = _linkdincont.text;
                      _educationdetalis = _educationdetaliscont.text;

                      _addItem(_name, _dob, _email, _mobileNumber, _skills,
                          _hob, _projectdetalis, _linkdin, _educationdetalis);
                    } else {
                      _name = _namecont.text;
                      _dob = _dobcont.text;
                      _email = _emailcont.text;
                      _mobileNumber = _mobilecont.text;
                      _skills = _skillscont.text;
                      _hob = _hobb.text;
                      _projectdetalis = _projectdetaliscont.text;
                      _linkdin = _linkdincont.text;
                      _educationdetalis = _educationdetaliscont.text;

                      updateData(
                          dataid,
                          _name,
                          _dob,
                          _email,
                          _mobileNumber,
                          _skills,
                          _hob,
                          _projectdetalis,
                          _linkdin,
                          _educationdetalis);
                    }
                    isresult = "done";
                    Navigator.of(context).pop(isresult);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addItem(_name, _dob, _email, _mobileNumber, _skill, _project,
      _hob, _linkd, _education) async {
    await DataSQL.createItem(_name, _dob!, _email, _mobileNumber, _skill,
        _project, _hob, _linkd!, _education);
  }

  Future<void> updateData(dataid, _name, _dob, _email, _mobileNumber, _skill,
      _project, _hob, _linkd, _education) async {
    await DataSQL.updateItem(dataid, _name, _dob, _email, _mobileNumber, _skill,
        _project, _hob, _linkd, _education);
  }
}
