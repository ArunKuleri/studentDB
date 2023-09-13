import 'package:flutter/material.dart';
import 'package:sd/model/studentdB.dart';
import 'package:sd/view/add_student/EditProfileScreen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  Future<List<User>> _fetchUser() async {
    final dbHelper = DatabaseHelper();
    return dbHelper.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: _fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<User> users = snapshot.data!;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final User user = users[index];
                  return Dismissible(
                    key: Key(user.username),
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16.0),
                    ),
                    secondaryBackground: Container(
                      color: Colors.blue,
                      child: const Icon(Icons.edit),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 16.0),
                    ),
                    child: Material(
                      child: Card(
                        child: ListTile(
                          title: Text(user.username),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.firstName}${user.lastName}",
                              ),
                              Text('Date of Birth: ${user.dob}'),
                              Text('Blood Group: ${user.bloodGroup}'),
                              Text('Division: ${user.division}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) ;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                EditProfileScreen(user: user)),
                          ));
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return const Text("Error retrieving data");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
