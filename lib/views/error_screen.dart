import 'package:mangamojo/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatefulWidget {
  late final String errorMessage;
  ErrorScreen(this.errorMessage);
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  Future<void> getData(String category) async {
    await Provider.of<DataService>(context, listen: false)
        .getHomeData(category: category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(
            Icons.error_outline,
            color: Colors.grey[700],
            size: 100,
          ),
          const SizedBox(height: 10),
          Text(
            'An Error Occurred',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              widget.errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                padding: EdgeInsets.symmetric(horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shadowColor: Colors.red,
              ),
              child: Text('Return Home'),
              onPressed: () {
                setState(() {
                  getData('airing');
                });
              })
        ],
      ),
    );
  }
}