import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/providers/todo_list.dart';

import './new_tasks_screen.dart';
import './finished_tasks_screen.dart';
import './account_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> bodyWidgets;
  void initState() {
    bodyWidgets = [
      {
        'page': FisnishedTasksScreen(),
        'title': 'Finished Tasks',
      },
      {
        'page': NewTasksScreen(),
        'title': 'ToDo List',
      },
      {
        'page': AccountScreen(),
        'title': 'Account',
      },
    ];
    super.initState();
  }

  int widgetIndex = 0;

  void selectPage(int index) {
    setState(() {
      widgetIndex = index;
    });
  }

  List<Color> colorList = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.deepOrange,
    Colors.black,
    Colors.green,
    Colors.indigo,
    Colors.purple,
  ];

  void bottomColorSelectSheet(TodoList provider) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
      context: context,
      builder: (_) {
        return Container(
          height: 200,
          child: Column(
            children: [
              SizedBox(height:10),
              Text("Filter by color: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.only(top:10),
                height: 150,
                child: GridView.builder(
                  itemCount: colorList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 160,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 3 / 1),
                  itemBuilder: (ctx, index) {
                    return IconButton(
                        icon: Icon(
                          Icons.bubble_chart,
                          color: colorList[index],
                          size: 30,
                        ),
                        onPressed: () {provider.setFilterColor(colorList[index]);Navigator.of(context).pop();});
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: ChangeNotifierProvider(
          create: (ctx) => TodoList(),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Builder(builder: (context) {
                  return PopupMenuButton(
                      onSelected: (selected) {
                        var provider =
                            Provider.of<TodoList>(context, listen: false);
                        if (selected == 2) 
                          bottomColorSelectSheet(provider);
                        provider.filterValueSet(selected);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      itemBuilder: (_) => <PopupMenuEntry>[
                            PopupMenuItem(
                                child: Text(
                                  'All',
                                ),
                                value: 0),
                            PopupMenuDivider(
                              height: 1,
                            ),
                            PopupMenuItem(
                                child: Row(
                                  children: [
                                    Text(
                                      'Date',
                                    ),
                                    Provider.of<TodoList>(context,
                                                listen: false)
                                            .dateFilterDir
                                        ? Text(" (new)")
                                        : Text(" (old)"),
                                  ],
                                ),
                                value: 1),
                            PopupMenuDivider(
                              height: 1,
                            ),
                            PopupMenuItem(
                                child: Text(
                                  'Color',
                                ),
                                value: 2),
                          ]);
                })
              ],
              centerTitle: true,
              title: Text(
                bodyWidgets[widgetIndex]['title'],
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: bodyWidgets[widgetIndex]['page'],
            bottomNavigationBar: BottomNavigationBar(
                onTap: selectPage,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.yellow,
                currentIndex: widgetIndex,
                backgroundColor: Theme.of(context).primaryColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle),
                    title: Text("Finished"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    title: Text("New"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text("Account"),
                  ),
                ]),
          ),
        ));
  }
}
