import 'dart:async';
import 'callApi.dart';

import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final Future<Search> post;

  SearchItem({Key key, this.post}) : super(key: key);

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: FutureBuilder<Search>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var errorCheck = snapshot.data.data.isEmpty;
              if (errorCheck == true) {
                return AlertDialog(
                  title: Text('The product ID is not available!'),
                );
              }
              List<dynamic> getData = snapshot.data.data;
              return DataTable(
                columnSpacing: 34,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('No.'),
                  ),
                  DataColumn(
                    label: Text('Product ID'),
                  ),
                  DataColumn(
                    label: Text('Brand'),
                  ),
                  DataColumn(
                    label: Text('Price (RM)'),
                  )
                ],
                rows: getData
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              (getData.indexOf(data) + 1).toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              data['id'].toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              data['brand'],
                            ),
                          ),
                          DataCell(
                            Text(
                              data['price'].toString(),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
