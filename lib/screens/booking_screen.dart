import 'package:flutter/material.dart';

import '../controllers/app_styles.dart';
import '../model/station_model.dart';
import '../widgets/custom_button.dart';


class BookingScreen extends StatefulWidget {
  final stationModel station;

  const BookingScreen({Key? key, required this.station}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 0);
  String _selectedVehicleType = 'Car';
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  final List<String> _vehicleTypes = ['Car', 'Motorcycle', 'Van', 'Truck', 'Bus'];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _bookAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment booked successfully!', style: TextStyle(
            fontSize: 16,
            fontFamily: "Montserrat",
            color: AppStyles.whiteColor
        ),),
        backgroundColor: Colors.green,
        margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment',style: TextStyle(
            fontSize: 25,
            color: Colors.grey[600],
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Station Info
                Card(
                  margin: EdgeInsets.only(bottom: 24),
                  shape: RoundedRectangleBorder(side: BorderSide(color: AppStyles.splashColor,width: 2),borderRadius: BorderRadius.circular(13)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            widget.station.type == 'Mechanic'
                                ? Icons.build
                                : Icons.local_gas_station,
                            size: 30,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.station.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${widget.station.distance.toStringAsFixed(1)} km away • ${widget.station.ratings} ★',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.station.type,
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Appointment Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedVehicleType,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Type',
                      labelStyle:  TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    prefixIcon: Icon(Icons.directions_car),
                  ),
                  items: _vehicleTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedVehicleType = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: _selectDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Date',
                        labelStyle:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      prefixIcon: Icon(Icons.calendar_today),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(_formatDate(_selectedDate)),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: _selectTime,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Time',
                        labelStyle:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      prefixIcon: Icon(Icons.access_time),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(_formatTime(_selectedTime)),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                    prefixIcon: Icon(Icons.description),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Book Appointment',
                    onPressed: _bookAppointment,
                    isLoading: _isLoading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}