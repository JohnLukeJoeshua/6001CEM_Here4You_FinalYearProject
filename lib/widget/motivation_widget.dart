import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../const/color_constant.dart';
import 'dart:convert';

class MotivationWidget extends StatefulWidget {
  const MotivationWidget({super.key});

  @override
  State<MotivationWidget> createState() => _MotivationWidgetState();
}

class _MotivationWidgetState extends State<MotivationWidget> {
  String? _quote;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final response = await http.get(
        Uri.parse('https://api.quotable.io/random?tags=motivational&maxLength=100'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          _quote = data['content'];
        });
      }
    } else {
      throw Exception('Failed to fetch quote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.grey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_quote == null)
              CircularProgressIndicator()
            else
              Text(
                _quote!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 0),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: _fetchQuote,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.black), // Replace the refresh icon with right arrow
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
