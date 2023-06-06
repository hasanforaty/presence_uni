import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/bloc/users_bloc.dart';
import 'package:presence_absence/consts/retrofit_utils.dart';
import 'package:presence_absence/models/dao/users_dao.dart';
import 'package:presence_absence/models/users.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../consts/Colors.dart';
import '../models/providers/retrofit_provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<UserDaoData> currentUser = [];
  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context);
    var rest = context.read<RetrofitProvider>().state;
    return Scaffold(
      body: FutureBuilder(
        future: Future.value().then((value) => pd.show()).then(
              (value) => getUsers(
                context: context,
                rest: rest,
              ),
            ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            pd.hide();
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: kLogInBackGround,
              child: BlocBuilder<UsersBloc, List<UserDaoData>>(
                builder: (context, list) {
                  print(list.length);
                  fillUsers(list);

                  return SafeArea(
                    child: AnimatedList(
                        key: _listKey,
                        itemBuilder: (context, index, controller) {
                          var curveAnimation = CurvedAnimation(
                              parent: controller, curve: Curves.bounceOut);
                          return SlideTransition(
                            position: curveAnimation.drive(_offset),
                            child: _UserWidget(user: currentUser[index]),
                          );
                        }),
                  );
                },
              ),
            );
          }
          return Container(
            color: kLogInBackGround,
          );
        },
      ),
    );
  }

  void fillUsers(List<UserDaoData> list) async {
    for (var user in list) {
      await Future.delayed(const Duration(milliseconds: 200));
      currentUser.add(user);
      _listKey.currentState?.insertItem(currentUser.length - 1);
    }
  }
}

class _UserWidget extends StatefulWidget {
  final UserDaoData user;
  const _UserWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<_UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<_UserWidget> {
  bool _extended = false;
  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    var kBlock = user.role == "block";
    var rest = context.read<RetrofitProvider>().state;
    // ListTile(
    //   contentPadding: const EdgeInsets.all(25),
    //   title: Text(
    //     user.name,
    //     style: Theme.of(context)
    //         .textTheme
    //         .titleMedium
    //         ?.copyWith(color: Colors.white),
    //     textDirection: TextDirection.rtl,
    //   ),
    //   subtitle: Text(
    //     user.email,
    //     style: Theme.of(context)
    //         .textTheme
    //         .titleSmall
    //         ?.copyWith(color: Colors.white),
    //     textDirection: TextDirection.rtl,
    //   ),
    // );
    return GestureDetector(
      onTap: () {
        setState(() {
          _extended = !_extended;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: kBlock ? Colors.grey : kDrawerBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              user.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              textDirection: TextDirection.rtl,
            ),
            Text(
              user.email,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
              textDirection: TextDirection.rtl,
            ),
            Visibility(
              visible: _extended,
              child: const Divider(
                height: 4,
                thickness: 4,
                endIndent: 8,
                indent: 8,
                color: Colors.grey,
              ),
            ),
            Visibility(
              visible: _extended,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Text(
                      kBlock ? "فعال کردن" : "غیر فعال کردن",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      changeUserRole(
                          rest: rest,
                          userId: user.id,
                          role: kBlock ? "controller" : "block");
                    },
                  ),
                  // GestureDetector(
                  //   child: Text(
                  //     "تغییر دسترسی کاربری",
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .titleSmall
                  //         ?.copyWith(color: Colors.white),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
