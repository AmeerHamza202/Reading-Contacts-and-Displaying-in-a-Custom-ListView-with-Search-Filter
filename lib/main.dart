//task 1
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:contacts_service/contacts_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Contacts Permission',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ContactsPage(),
//     );
//   }
// }

// class ContactsPage extends StatefulWidget {
//   const ContactsPage({super.key});

//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }

// class _ContactsPageState extends State<ContactsPage> {
//   bool _hasPermission = false;

//   // Function to request contact permissions
//   Future<void> _requestPermission() async {
//     PermissionStatus permission = await Permission.contacts.request();

//     if (permission.isGranted) {
//       setState(() {
//         _hasPermission = true;
//       });
//     } else {
//       setState(() {
//         _hasPermission = false;
//       });
//     }
//   }

//   // Function to retrieve and display contacts
//   Future<List<Contact>> _getContacts() async {
//     if (_hasPermission) {
//       Iterable<Contact> contacts = await ContactsService.getContacts();
//       return contacts.toList();
//     } else {
//       return [];
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _requestPermission(); // Request permission on startup
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contacts Permission Example'),
//       ),
//       body: Center(
//         child: _hasPermission
//             ? FutureBuilder<List<Contact>>(
//                 future: _getContacts(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Text('No contacts found.');
//                   } else {
//                     List<Contact> contacts = snapshot.data!;
//                     return ListView.builder(
//                       itemCount: contacts.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(contacts[index].displayName ?? 'No name'),
//                         );
//                       },
//                     );
//                   }
//                 },
//               )
//             : const Text('Permission denied.'),
//       ),
//     );
//   }
// }

//task2
// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Contacts List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.light,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ContactsPage(),
//     );
//   }
// }

// class ContactsPage extends StatefulWidget {
//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }

// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> _contacts = [];

//   @override
//   void initState() {
//     super.initState();
//     _requestPermissionAndLoadContacts();
//   }

//   // Request permissions and load contacts
//   Future<void> _requestPermissionAndLoadContacts() async {
//     // Request permission to access contacts
//     var status = await Permission.contacts.request();

//     if (status.isGranted) {
//       // If granted, load contacts
//       _loadContacts();
//     } else {
//       // If permission is denied, show a message
//       _showPermissionDeniedMessage();
//     }
//   }

//   // Load contacts from the device
//   Future<void> _loadContacts() async {
//     // Fetch contacts
//     List<Contact> contacts = await ContactsService.getContacts();
//     setState(() {
//       _contacts = contacts;
//     });
//   }

//   // Show permission denied message
//   void _showPermissionDeniedMessage() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Permission Denied', style: TextStyle(color: Colors.red)),
//         content: Text('Please grant contacts permission to proceed.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contacts List',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.teal,
//       ),
//       body: _contacts.isEmpty
//           ? Center(child: CircularProgressIndicator()) // Show loading indicator
//           : ListView.builder(
//               itemCount: _contacts.length,
//               itemBuilder: (context, index) {
//                 Contact contact = _contacts[index];

//                 // Custom-designed list item with colorful design
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   elevation: 5,
//                   color: Colors.teal[50], // Light color for card background
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(15),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.teal,
//                       child: Text(
//                         contact.displayName != null
//                             ? contact.displayName![0].toUpperCase()
//                             : 'N', // First letter of the name or N if no name
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       contact.displayName ?? 'No Name',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.teal[800],
//                       ),
//                     ),
//                     subtitle: contact.phones!.isNotEmpty
//                         ? Text(
//                             contact.phones!.first.value ?? 'No Phone',
//                             style: TextStyle(color: Colors.teal[600]),
//                           )
//                         : Text('No Phone',
//                             style: TextStyle(color: Colors.grey)),
//                     trailing: IconButton(
//                       icon: Icon(Icons.message, color: Colors.teal),
//                       onPressed: () {
//                         // Implement messaging functionality here
//                       },
//                     ),
//                     onTap: () {
//                       // Implement onTap functionality here
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

//task3
// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Colorful Contacts List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.light,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ContactsPage(),
//     );
//   }
// }

// class ContactsPage extends StatefulWidget {
//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }

// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> _contacts = [];

//   @override
//   void initState() {
//     super.initState();
//     _requestPermissionAndLoadContacts();
//   }

//   // Request permissions and load contacts
//   Future<void> _requestPermissionAndLoadContacts() async {
//     var status = await Permission.contacts.request();

//     if (status.isGranted) {
//       _loadContacts();
//     } else {
//       _showPermissionDeniedMessage();
//     }
//   }

//   // Load contacts from the device
//   Future<void> _loadContacts() async {
//     List<Contact> contacts = await ContactsService.getContacts();
//     setState(() {
//       _contacts = contacts;
//     });
//   }

//   // Show permission denied message
//   void _showPermissionDeniedMessage() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Permission Denied', style: TextStyle(color: Colors.red)),
//         content: Text('Please grant contacts permission to proceed.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contacts List',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.teal,
//       ),
//       body: _contacts.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _contacts.length,
//               itemBuilder: (context, index) {
//                 Contact contact = _contacts[index];

//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   elevation: 8,
//                   color: index % 2 == 0 ? Colors.teal[50] : Colors.teal[100],
//                   child: ListTile(
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.teal[300],
//                       child: Text(
//                         contact.displayName != null
//                             ? contact.displayName![0].toUpperCase()
//                             : 'N',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       contact.displayName ?? 'No Name',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.teal[800],
//                       ),
//                     ),
//                     subtitle: contact.phones!.isNotEmpty
//                         ? Padding(
//                             padding: const EdgeInsets.only(top: 4.0),
//                             child: Text(
//                               contact.phones!.first.value ?? 'No Phone',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.teal[600],
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 4.0),
//                             child: Text(
//                               'No Phone',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.message, color: Colors.teal[700]),
//                       onPressed: () {
//                         // Implement messaging functionality here
//                       },
//                     ),
//                     onTap: () {
//                       // Implement onTap functionality here
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

//task4
// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Colorful Contacts List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.light,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ContactsPage(),
//     );
//   }
// }

// class ContactsPage extends StatefulWidget {
//   @override
//   _ContactsPageState createState() => _ContactsPageState();
// }

// class _ContactsPageState extends State<ContactsPage> {
//   List<Contact> _contacts = [];
//   List<Contact> _filteredContacts = [];
//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _requestPermissionAndLoadContacts();
//     _searchController.addListener(_filterContacts);
//   }

//   // Request permissions and load contacts
//   Future<void> _requestPermissionAndLoadContacts() async {
//     var status = await Permission.contacts.request();

//     if (status.isGranted) {
//       _loadContacts();
//     } else {
//       _showPermissionDeniedMessage();
//     }
//   }

//   // Load contacts from the device
//   Future<void> _loadContacts() async {
//     List<Contact> contacts = await ContactsService.getContacts();
//     setState(() {
//       _contacts = contacts;
//       _filteredContacts = contacts;
//     });
//   }

//   // Show permission denied message
//   void _showPermissionDeniedMessage() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Permission Denied', style: TextStyle(color: Colors.red)),
//         content: Text('Please grant contacts permission to proceed.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Filter contacts based on the search query
//   void _filterContacts() {
//     String query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredContacts = _contacts.where((contact) {
//         return contact.displayName?.toLowerCase().contains(query) ?? false;
//       }).toList();
//     });
//   }

//   @override
//   void dispose() {
//     _searchController
//         .dispose(); // Clean up the controller when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contacts List',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.teal,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search contacts...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.teal),
//                 ),
//                 prefixIcon: Icon(Icons.search, color: Colors.teal),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _filteredContacts.isEmpty
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: _filteredContacts.length,
//                     itemBuilder: (context, index) {
//                       Contact contact = _filteredContacts[index];

//                       return Card(
//                         margin:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         elevation: 8,
//                         color:
//                             index % 2 == 0 ? Colors.teal[50] : Colors.teal[100],
//                         child: ListTile(
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 10),
//                           leading: CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.teal[300],
//                             child: Text(
//                               contact.displayName != null
//                                   ? contact.displayName![0].toUpperCase()
//                                   : 'N',
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                             ),
//                           ),
//                           title: Text(
//                             contact.displayName ?? 'No Name',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.teal[800],
//                             ),
//                           ),
//                           subtitle: contact.phones!.isNotEmpty
//                               ? Padding(
//                                   padding: const EdgeInsets.only(top: 4.0),
//                                   child: Text(
//                                     contact.phones!.first.value ?? 'No Phone',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.teal[600],
//                                       fontStyle: FontStyle.italic,
//                                     ),
//                                   ),
//                                 )
//                               : Padding(
//                                   padding: const EdgeInsets.only(top: 4.0),
//                                   child: Text(
//                                     'No Phone',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
//                                 ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.message, color: Colors.teal[700]),
//                             onPressed: () {
//                               // Implement messaging functionality here
//                             },
//                           ),
//                           onTap: () {
//                             // Implement onTap functionality here
//                           },
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndLoadContacts();
    _searchController.addListener(_filterContacts);
  }

  // Request permissions and load contacts
  Future<void> _requestPermissionAndLoadContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      _loadContacts();
    } else {
      _showPermissionDeniedMessage();
    }
  }

  // Load contacts from the device
  Future<void> _loadContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      _filteredContacts = contacts;
      _isLoading = false;
    });
  }

  // Show permission denied message
  void _showPermissionDeniedMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Denied', style: TextStyle(color: Colors.red)),
        content: Text('Please grant contacts permission to proceed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Filter contacts based on the search query
  void _filterContacts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        return contact.displayName?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController
        .dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search, size: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
              ),
            ),
          ),
          // Loading or Contacts List
          Expanded(
            child: _isLoading
                ? Center(
                    child:
                        CircularProgressIndicator()) // Show loading indicator
                : _filteredContacts.isEmpty
                    ? Center(
                        child: Text('No contacts found',
                            style: TextStyle(fontSize: 18, color: Colors.grey)))
                    : ListView.builder(
                        itemCount: _filteredContacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = _filteredContacts[index];

                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 8,
                            color: index % 2 == 0
                                ? Colors.blue[50]
                                : Colors.blue[100],
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blueAccent,
                                child: Text(
                                  contact.displayName != null
                                      ? contact.displayName![0].toUpperCase()
                                      : 'N',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                              title: Text(
                                contact.displayName ?? 'No Name',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              subtitle: contact.phones!.isNotEmpty
                                  ? Text(
                                      contact.phones![0].value ?? 'No Phone',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue[600]),
                                    )
                                  : Text(
                                      'No Phone',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600]),
                                    ),
                              trailing: IconButton(
                                icon: Icon(Icons.message,
                                    color: Colors.blueAccent),
                                onPressed: () {
                                  // Implement messaging functionality here
                                },
                              ),
                              onTap: () {
                                // Implement onTap functionality here
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
