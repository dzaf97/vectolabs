import 'dart:async';
import 'callApi.dart';

import 'package:flutter/material.dart';

class ShowItem extends StatelessWidget {
  final Future<Post> post;

  ShowItem({Key key, this.post}) : super(key: key);

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'List of items',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> getData = snapshot.data.data;
              return Scrollbar(
                child: SingleChildScrollView(
                  child: DataTable(
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
                      ),
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
                  ),
                ),
              );
              //Text(snapshot.data.title);
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
