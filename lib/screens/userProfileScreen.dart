import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  late String firstName;
  late String lastName;
  late String country;
  late String city;
  late String address1;
  late String email;
  late String phone;

  UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoaded = false;
  final _formKey = GlobalKey<FormState>();

  void initState() {
    loadSharedData();
  }

  Future<void> loadSharedData() async {
    final shared = await SharedPreferences.getInstance();

    widget.firstName = shared.getString('firstName') ?? '';
    widget.lastName = shared.getString('lastName') ?? '';
    widget.country = shared.getString('country') ?? '';
    widget.city = shared.getString('city') ?? '';
    widget.address1 = shared.getString('address1') ?? '';
    widget.email = shared.getString('email') ?? '';
    widget.phone = shared.getString('phone') ?? '';
    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> saveSharedData() async {
    final shared = await SharedPreferences.getInstance();

    if (widget.firstName.isNotEmpty) {
      shared.setString('firstName', widget.firstName);
    }
    if (widget.lastName.isNotEmpty) {
      shared.setString('lastName', widget.lastName);
    }
    if (widget.country.isNotEmpty) {
      shared.setString('country', widget.country);
    }
    if (widget.city.isNotEmpty) {
      shared.setString('city', widget.city);
    }

    if (widget.address1.isNotEmpty) {
      shared.setString('address1', widget.address1);
    }
    if (widget.email.isNotEmpty) {
      shared.setString('email', widget.email);
    }
    if (widget.phone.isNotEmpty) {
      shared.setString('phone', widget.phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: _isLoaded
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: widget.firstName,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Ex. Popescu',
                          labelText: 'Nume *',
                        ),
                        onSaved: (String? value) {
                          widget.firstName = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.lastName,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Ex. Ion',
                          labelText: 'Prenume *',
                        ),
                        onSaved: (String? value) {
                          widget.lastName = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.email,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Ion@popescu.ro',
                          labelText: 'Email *',
                        ),
                        onSaved: (String? value) {
                          widget.email = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.phone,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          hintText: '0722334422',
                          labelText: 'Telefon *',
                        ),
                        onSaved: (String? value) {
                          widget.phone = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.country,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.flag),
                          hintText: 'Romania',
                          labelText: 'Tara *',
                        ),
                        onSaved: (String? value) {
                          widget.country = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.city,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.streetview),
                          hintText: 'Bucuresti',
                          labelText: 'Oras *',
                        ),
                        onSaved: (String? value) {
                          widget.city = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.address1,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.map),
                          hintText: 'Strada strazilor, nr. 11',
                          labelText: 'Adresa *',
                        ),
                        onSaved: (String? value) {
                          widget.address1 = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Te rugam sa introduci o valoare';
                          }
                          return null;
                        },
                      ),

                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Procesez datele...')),
                            );

                            _formKey.currentState!.save();
                            saveSharedData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Salvat!')),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      // Add TextFormFields and ElevatedButton here.
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
