import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PropertyForm(),
    );
  }
}

class PropertyForm extends StatefulWidget {
  @override
  State<PropertyForm> createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController squareFootageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();
  TextEditingController depositsController = TextEditingController();
  TextEditingController documentsController = TextEditingController();
  TextEditingController termsAndConditionsController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();
  String? selectedPropertyType;
  int? selectedBedrooms;
  String? Furnished;
  List<File> images = [];
  DateTime? availableDate;
  bool utilitiesIncluded = false; // Checkbox for utilities included
  bool petsAllowed = false; // Checkbox for pets allowed

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        images.add(File(pickedImage.path));
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != availableDate) {
      setState(() {
        availableDate = pickedDate;
      });
    }
  }

  void _submitForm() {
    // Process the form data
    print('Form submitted!');
    print('Title: ${titleController.text}');
    print('Property Type: $selectedPropertyType');
    print('Number of Bedrooms: $selectedBedrooms');
    print('Square Footage: ${squareFootageController.text}');
    print('Price Per Month: ${priceController.text}');
    print('Furnished: $Furnished');
    print('Description: ${termsAndConditionsController.text}');
    print('Location: ${locationController.text}');
    print('photos: $images');
    print('Available Date: $availableDate');
    print('Contact Information: ${contactInfoController.text}');
    print('Deposits and Security: ${depositsController.text}');
    print('Documents Required: ${documentsController.text}');
    print('Utilities Included: $utilitiesIncluded');
    print('Pets Allowed: $petsAllowed');
    print('Terms and Conditions: ${termsAndConditionsController.text}');
    print('Additional Information: ${additionalInfoController.text}');
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    titleController.dispose();
    squareFootageController.dispose();
    priceController.dispose();
    depositsController.dispose();
    locationController.dispose();
    contactInfoController.dispose();
    depositsController.dispose();
    documentsController.dispose();
    termsAndConditionsController.dispose();
    additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Rental Ad Post Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: titleController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText:
                          'Enter a descriptive title for your property rental listing',
                      labelText: 'Title'),
                ),
                SizedBox(height: 10),

                // Dropdown for Property Type
                Text(
                  'Property Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: selectedPropertyType,
                  hint: Text('Select Property Type'),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPropertyType = newValue;
                    });
                  },
                  items: <String>['Apartment', 'House', 'Condo', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                // Dropdown for Number of Bedrooms
                Text(
                  'Number of Bedrooms',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<int>(
                  validator: (int? value) {
                    if (value == null) {
                      return 'Please select the number of bedrooms';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: selectedBedrooms,
                  hint: Text('Select Number of Bedrooms'),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedBedrooms = newValue;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                Text(
                  'Square Footage',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: squareFootageController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText:
                        'Enter the square footage or size of the property (in sq.ft. or sq. meters)',
                    labelText: 'Square Footage',
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Price Per Month',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: priceController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter the rental price per month in USD',
                    labelText: 'Price',
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Furnished',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: Furnished,
                  hint: Text('Select'),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? newValue) {
                    setState(() {
                      Furnished = newValue;
                    });
                  },
                  items: <String>[
                    'Furnished',
                    'Unfurnished',
                    'Partially Furnished'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter detailed description of the property',
                    labelText: 'Description',
                  ),
                  maxLines: null, // Set maxLines to null for multiline input
                ),
                SizedBox(height: 10),

                Text(
                  'Upload Photos',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Display selected images
                Container(
                  height: 200,
                  child: images.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: images.map((File image) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    Image.file(
                                      image,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            images.remove(image);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : Center(
                          child: Text(
                            'Please pick at least one image.',
                            style: TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  child: Text('Pick Images from Gallery'),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                  child: Text('Capture Image from Camera'),
                ),
                SizedBox(height: 10),

                Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: locationController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText:
                        "Enter the property's location , including address details",
                    labelText: 'Location',
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Available Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Display selected available date
                (availableDate != null)
                    ? Text(
                        'Selected Date: ${DateFormat('yyyy-MM-dd').format(availableDate!)}',
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(
                        'required*',
                        style: TextStyle(color: Colors.red),
                      ),
                SizedBox(height: 10),

                // Button to select the available date
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text('Select Available Date'),
                ),
                SizedBox(height: 10),

                Text(
                  'Contact Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: contactInfoController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText:
                        "Enter your contact information for potential renters to reach you",
                    labelText: 'Contact Information',
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Deposits and Security',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: depositsController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText:
                        "Specify any security deposit or upfront payment required from renters",
                    labelText: 'Deposits and Security',
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Documents Required',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: documentsController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText:
                        "List the necssary documents or identification that renters must provide",
                    labelText: 'Documents Required',
                  ),
                  maxLines: null,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Utilities Included',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Checkbox for Utilities Included
                Row(
                  children: [
                    Checkbox(
                      value: utilitiesIncluded,
                      onChanged: (bool? value) {
                        setState(() {
                          utilitiesIncluded = value!;
                        });
                      },
                    ),
                    Text('Utilities Included'),
                  ],
                ),
                SizedBox(height: 15),

                Text(
                  'Pets Allowed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                // Checkbox for Pets Allowed
                Row(
                  children: [
                    Checkbox(
                      value: petsAllowed,
                      onChanged: (bool? value) {
                        setState(() {
                          petsAllowed = value!;
                        });
                      },
                    ),
                    Text('Pets Allowed'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Terms and Conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                TextFormField(
                  controller: termsAndConditionsController,
                  validator: ValidationBuilder().required().build(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: "Provide any terms and conditions",
                    labelText: 'Terms and Conditions',
                  ),
                  maxLines: null,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Additional Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: additionalInfoController,
                  decoration: InputDecoration(
                    hintText:
                        "Include any specific rental terms , requirements ,or special instructions for renters",
                    labelText: 'Additional Information',
                  ),
                  maxLines: null,
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ??
                              false & images.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Please pick at least one image.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            _submitForm();
                          }
                        },
                        child: Text('Submit Form'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
