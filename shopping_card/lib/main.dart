import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<IconData> icons = [
    Icons.abc,
    Icons.abc_sharp,
    Icons.access_alarm,
    Icons.ac_unit_outlined,
    Icons.abc_sharp,
    Icons.access_alarm,
    Icons.ac_unit_outlined,
  ];

  List<int> incre=[];

  @override
  void initState()
  {
    super.initState();
    incre=[0,0,0,0,0,0,0];
  }

  void increment(int index)
  {
    incre[index]=incre[index]+1;
  }

  void decrement(int index)
  {
    incre[index]=incre[index]-1;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(

        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context,index){
                return Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                            width: 5.0,
                            color: Colors.blue
                          ),
                           right:  BorderSide(
                               width: 8.0,
                               color: Colors.blue
                           ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                          children: [
                            Icon(icons[index],size: 100,color: Colors.blueAccent,),
                            SizedBox(width: 20,),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("${index+1} item",style: TextStyle(color: Colors.black,fontSize: 20),),
                                Text("describtion"),
                               // SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(onPressed: (){
                                      setState((){
                                        increment(index);
                                      });
                                    }, icon: Icon(Icons.add)),
                                    Text("${incre[index]}"),
                                    IconButton(onPressed: (){
                                      setState(() {
                                        decrement(index);
                                      });
                                    }, icon: Icon(Icons.remove)),

                                  ],
                                )
                              ],
                            )),
                          ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
