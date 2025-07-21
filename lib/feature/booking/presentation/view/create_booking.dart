// lib/features/booking/presentation/pages/create_booking_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/app_colors.dart';
import '../../../customer_service/domain/entity/service_entity.dart';
import '../view_model/booking_event.dart';
import '../view_model/booking_state.dart';
import '../view_model/booking_view_model.dart';

class CreateBookingScreen extends StatefulWidget {
  final ServiceEntity service;
  const CreateBookingScreen({super.key, required this.service});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bikeModelController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _bikeModelController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      // Optional: Force re-validation when a date is selected
      // _formKey.currentState?.validate();
    }
  }

  void _submitBooking() {
    // --- START OF DEBUGGING CODE ---
    // Add these print statements to see the values right before the crash.
    print('--- SUBMITTING BOOKING ---');
    print('Value of widget.service.serviceId: ${widget.service.serviceId}');
    print('Value of _selectedDate: $_selectedDate');
    // --- END OF DEBUGGING CODE ---

    if (_formKey.currentState!.validate()) {
      // The crash happens on the next line if one of the values is null.
      context.read<BookingViewModel>().add(
            CreateBookingEvent(
              serviceId: widget.service.serviceId!,
              bikeModel: _bikeModelController.text.trim(),
              date: _selectedDate!,
              notes: _notesController.text.trim(),
            ),
          );
    } else {
      print('--- FORM VALIDATION FAILED ---');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: const Text('Create Booking'),
        backgroundColor: AppColors.cardBackground,
        foregroundColor: AppColors.textWhite,
      ),
      body: BlocListener<BookingViewModel, BookingState>(
        listener: (context, state) {
          if (state is BookingActionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.accentGreen,
                ),
              );
            Navigator.of(context)
              ..pop()
              ..pop();
          } else if (state is BookingFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.redAccent,
                ),
              );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildServiceDetails(),
                const SizedBox(height: 24),
                _buildTextFormField(
                  controller: _bikeModelController,
                  labelText: 'Bike Model (e.g., Pulsar 220)',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your bike model' : null,
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _dateController,
                  labelText: 'Booking Date',
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (_) {
                    if (_selectedDate == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  controller: _notesController,
                  labelText: 'Additional Notes (Optional)',
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: AppColors.primaryDark,
                    ),
                    child: BlocBuilder<BookingViewModel, BookingState>(
                      builder: (context, state) {
                        if (state is BookingLoading) {
                          return const SizedBox(
                            height: 24,
                            width: 24,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          );
                        }
                        return const Text(
                          'Confirm Booking',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
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

  Widget _buildServiceDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Service',
            style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const Divider(color: AppColors.accentGreen),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.service.name,
                  style: const TextStyle(
                      color: AppColors.textWhite, fontSize: 16)),
              Text('Rs. ${widget.service.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                      color: AppColors.accentGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    bool readOnly = false,
    int? maxLines = 1,
    void Function()? onTap,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.textWhite.withOpacity(0.7)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.accentGreen),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
      style: const TextStyle(color: AppColors.textWhite),
      validator: validator,
      readOnly: readOnly,
      maxLines: maxLines,
      onTap: onTap,
    );
  }
}
