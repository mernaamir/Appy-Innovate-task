import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "searchscreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<QuerySnapshot> _future;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _future = getPersonStream();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    setState(() {});
  }

  Future<QuerySnapshot> getPersonStream() async {
    try {
      return FirebaseFirestore.instance
          .collection('Persons')
          .orderBy('nationalityID')
          .get();
    } catch (error) {
      throw Exception("$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          controller: _searchController,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final List<DocumentSnapshot> allResults =
            snapshot.data!.docs as List<DocumentSnapshot>;

            final List<DocumentSnapshot> resultList = _searchController.text.isNotEmpty
                ? allResults.where((personSnapshot) {
              return personSnapshot['nationalityID']
                  .toString()
                  .contains(_searchController.text);
            }).toList()
                : allResults;

            if (resultList.isEmpty) {
              return const Center(child: Text("No results found"));
            } else {
              return ListView.builder(
                itemCount: resultList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(resultList[index]['name'].toString()),
                      Text(resultList[index]['age'].toString()),
                      Text(resultList[index]['nationalityID'].toString()),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}