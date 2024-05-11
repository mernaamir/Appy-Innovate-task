// import 'package:flutter/material.dart';
// import 'package:interview/person_model.dart';
// import 'edit_person.dart';
// import 'firebase_functions.dart';
//
// class SearchScreen extends SearchDelegate{
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [IconButton(onPressed: (){}, icon: Icon(Icons.search))];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//   return IconButton(onPressed: (){
//     Navigator.pop(context);
//   }, icon: Icon(Icons.close));
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//   return  Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: FutureBuilder(
//         future: firebaseFunctions.getpersons(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Text("something went error");
//           }
//           List<PersonModel> personList =
//               snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
//           if (personList.isEmpty) {
//             return const Text("List is empty ");
//           }
//           return ListView.separated(
//             separatorBuilder: (context, index) => const SizedBox(
//               height: 10,
//             ),
//             itemBuilder: (context, index) {
//               return Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.grey.shade200
//                 ),
//                 child: Column(
//                   children: [
//                     Text(personList[index].name ?? "", style: TextStyle(fontSize: 20),),
//                     Text(personList[index].age.toString() ?? ""),
//                     Text(personList[index].nationalityID.toString() ??
//                         ""),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               String personIdToDelete =
//                                   personList[index].personID;
//                               firebaseFunctions
//                                   .deleteperson(personIdToDelete);
//
//                             },
//                             icon: const Icon(Icons.delete)),
//                         IconButton(
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, EditPersonScreen.routeName,
//                                   arguments: personList[index]);
//                             },
//                             icon: const Icon(Icons.edit))
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             },
//             itemCount: personList.length,
//           );
//         }),
//   );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
// return Container();
//   }
//
// }