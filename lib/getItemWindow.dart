import 'dart:async';
import 'callApi.dart';

import 'package:flutter/material.dart';

class ShowItem extends StatefulWidget {
  final Future<Post> post;

  const ShowItem({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ShowItemState();
  }
}

class ShowItemState extends State<ShowItem> {
  var _sortAsceding = true;

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
          future: widget.post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> getData = snapshot.data.data;
              return Scrollbar(
                child: SingleChildScrollView(
                  child: DataTable(
                    sortColumnIndex: 3,
                    sortAscending: _sortAsceding,
                    columnSpacing: 34,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('No.'),
                      ),
                      DataColumn(
                          label: Text('Product ID'),
                          onSort: (i, b) {
                            setState(() {
                              if (_sortAsceding) {
                                getData.sort(
                                  (a, b) => b['id'].compareTo(a['id']),
                                );
                                _sortAsceding = false;
                              } else {
                                getData.sort(
                                  (a, b) => a['id'].compareTo(b['id']),
                                );
                                _sortAsceding = true;
                              }
                            });
                          }),
                      DataColumn(
                        label: Text('Brand'),
                        numeric: false,
                        onSort: (i, b) {
                          setState(
                            () {
                              getData.sort(
                                (a, b) => a['brand'].compareTo(b['brand']),
                              );
                            },
                          );
                        },
                      ),
                      DataColumn(
                        label: Text('Price (RM)'),
                        numeric: true,
                        onSort: (i, _sortAscending) {
                          setState(
                            () {
                              if (_sortAsceding) {
                                getData.sort((a, b) => double.parse(b['price'])
                                    .compareTo(double.parse(a['price'])));
                                _sortAsceding = false;
                              } else {
                                getData.sort((a, b) => double.parse(a['price'])
                                    .compareTo(double.parse(b['price'])));
                                _sortAsceding = true;
                              }
                            },
                          );
                        },
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
