import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatefulWidget
{
  MyApp({super.key});
  @override
  State<MyApp> createState()=>_MyApp();
}
class _MyApp extends State<MyApp>
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget
{
  Calculator({super.key});
  @override
  State<Calculator> createState()=>_Calculator();
}
class _Calculator extends State<Calculator>
{
  String text='0';
  String result='0';
  bool isshow=false;
  void addtext(String str)
  {
    int len=str.length;
    if(text=='0' && len==1)
      text=str;
    else
    text=text+str;
  }
  void removetext()
  {
    int len=text.length-1;
    List<String> chars=text.split('');
    print(chars);
    chars.removeAt(len);
    if(chars.length==0)
      text='0';
    else
    text=chars.join('');
    // text=text.replaceRange(len, len-1, '');
  }
  void clearall()
  {
    text='0';
    result='0';
  }
  void buttonpressed(String button)
  {
    isshow=false;

    if(button=='◀️')
      removetext();
    else if(button == 'CE')
      clearall();
    else if(button == "=")
      {
        evalution(text);
        isshow=true;
      }
    else
      {
        addtext(button);
          evalution(text);
      }



    setState(() {});
  }
  String sublist({required List<String> str,required int stop,int start=0})
  {
    String st='';
    List<String> part=str;
    for(int i=start;i<stop;i++)
      {
        if(!(part[i] == '+' || part[i]=='*' || part[i]=='-' ||part[i]=='+' ||part[i]=='/' || part[i]=='%'))
        st=st+str[i];
      }
    return st;
  }
  void evalution(String str)
  {
    List<String> part=str.split('');
    List<double> numbers=[];
    List<String> opration=[];
    print(part);
    int len=part.length;
    int start=0,stop=0;
    for(int i=0;i<len;i++)
      {
        if(part[i] == '+' || part[i]=='*' || part[i]=='-' ||part[i]=='+' ||part[i]=='/' ||i==len-1 || part[i]=='%')
          {
            String n='';
            stop=i;
            if(i==len-1)
             stop++;

            n=sublist(str: part, stop:stop,start: start);
            if(n!='' && n.isNotEmpty)
              {
                numbers.add(double.parse(n));
                if(part[i] == '+' || part[i]=='*' || part[i]=='-' ||part[i]=='+' ||part[i]=='/' || part[i]=='%')
                opration.add(part[i]);
              }

            start=i+1;

          }
      }
    print(numbers);
    print(opration);
    calculate(numbers, opration);
  }
  void calculate(List<double> numbers,List<String> opration)
  {
            int count=-1;
            int len=numbers.length;
            double resul=0;
            resul=numbers[0];
            for(int i=0;i<len;i++)
              {
                if(count==-1)
                 resul=calc(resul,numbers[i],'');
                else
                  resul=calc(resul,numbers[i],opration[count]);
                count++;
              }
            print(resul);
            result=resul.toString();

  }
  double calc(double result,double ope,String op)
  {
    double re=0.0;
    switch(op)
    {
      case '+':re=result+ope;
                    break;
      case '-':re=result-ope;
                    break;
      case '/':re=result/ope;
                    break;
      case '*':re=result*ope;
                    break;
      case '%':re=result%ope;
                     break;
      default:re=result;
    }
    return re;
  }

  @override
  Widget build(BuildContext context)
  {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    // Adjust font size based on screen width
    double textFontSize = width * 0.12; // 12% of screen width
    double resultFontSize = width * 0.09; // 9% of screen width
    double buttonFontSize = width * 0.06; // 6% of screen width
    return Scaffold(
      body: Column(
        children: [
          !isshow?SizedBox(
              height: height*0.3,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: AutoSizeText(text,
                  style: TextStyle(fontSize: textFontSize),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05),
                  child:AutoSizeText(result,
                    style: TextStyle(fontSize: resultFontSize,color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                  )
                ),
                            ],
                          ),
              )):SizedBox(
              height: height*0.3,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: AutoSizeText(result,
                    style: TextStyle(fontSize: textFontSize),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                  ),
          ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(width*0.02),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context,index){
                String button=getbutton(index);
                if(button == '=')
                  return GestureDetector(
                    onTap: (){
                      buttonpressed(button);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(width*0.03),
                      ),
                      child: Center(
                        child: Text("$button",style: TextStyle(fontSize: resultFontSize),),
                      ),
                    ),
                  );
                  else
                    return GestureDetector(
                 onTap: (){
                   buttonpressed(button);
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.blueGrey,
                     borderRadius: BorderRadius.circular(width*0.03),
                     border: Border(bottom: BorderSide(
                       color: Colors.white,
                       width: 5,
                     ),
                     right: BorderSide(
                       color: Colors.white,
                       width: 5,
                     )
                     )
                   ),
                   child: Center(
                     child: Text("$button",style: TextStyle(fontSize: resultFontSize),),
                   ),
                 ),
               );
                }),
          ))

        ],
      ),
    );
  }
}

String getbutton(int index)
{
  String str='';
  switch(index)
      {
    case 0:str='1';
               break;
    case 1:str='2';
               break;
    case 2:str='3';
                break;
    case 3:str='CE';
                break;
    case 4:str='4';
                break;
    case 5:str='5';
                break;
    case 6:str='6';
                  break;
    case 7:str='◀️';
                  break;
    case 8:str='7';
                     break;
    case 9:str='8';
                   break;
    case 10:str='9';
                 break;
    case 11:str='+';
                break;
    case 12:str='.';
                  break;
    case 13:str='0';
                   break;
    case 14:str='00';
                  break;
    case 15:str='*';
                  break;
    case 16:str='/';
                  break;
    case 17:str='-';
                   break;
    case 18:str='%';
                       break;
    case 19:str='=';
                break;

  }
     return str;
}