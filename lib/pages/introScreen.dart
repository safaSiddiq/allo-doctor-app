import 'package:allo_doctor/pages/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
   final mainColor=  LinearGradient(
         // tileMode: TileMode.mirror,
          //  begin: Alignment.topCenter,
          //  end: Alignment.bottomCenter,
          begin: FractionalOffset.topCenter,
          //  end: FractionalOffset.bottomCenter,
          stops: [0.0, 1.0,],
          colors: [
            Color(0xFF87C9BF),
            Color(0xFF2B95AF)
          ],
        );
  
  @override
  Widget build(BuildContext context) {
 
    return Container(
decoration: BoxDecoration(
gradient: mainColor
),
    child:
    IntroductionScreen(
      key: introKey,
    globalBackgroundColor: Color(0x00000000),
      dotsDecorator: DotsDecorator(
        activeColor: Colors.tealAccent,
        color: Colors.white,
        activeSize: Size.square(17)
      ),
      pages: [
        PageViewModel(
          
          title: "allo doctor",
         // body:"data " ,
          bodyWidget: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              height: 120,
            ),
          )
        ),
        PageViewModel(
           title: "allo doctor",
          bodyWidget: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              height: 90,
            ),
          )
        ),
        PageViewModel(
           title: "allo doctor", 
          bodyWidget: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              height: 90,
            ),
          )
        )
      ],
      showSkipButton: true,
      skip:  Text('تخطي', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 17)),
      // onSkip: (){
      // },
       onDone: (){
         Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
       },
       done:  Text('التالي', style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600)),
    )
    );
  }
    
}
//   SwiperController _controller = SwiperController();
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Swiper(
//             scrollDirection: Axis.horizontal,
//             loop: false,
//             index: _currentIndex,
//             onIndexChanged: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             controller: _controller,
//             pagination: SwiperPagination(
//               builder: DotSwiperPaginationBuilder(
//                 activeColor: Colors.white54,
//                 activeSize: 20.0,
//               ),
//             ),
//             itemCount: 4,
//             itemBuilder: (context, index) {
//               if (_currentIndex < 3) {
//                 return IntroItem();
//               } else {
//                 return LoginScreen();
//               }
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: FlatButton(
//               child: Text(
//                 "تخطي",
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () {
    
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class IntroItem extends StatelessWidget {
//   const IntroItem({Key key
//       //,this.imageUrl
//       })
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//                     colors: [
//                        Colors.teal[300],
//                       Colors.teal,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),),
//       child: SafeArea(
//         child: Padding(
//             padding: EdgeInsets.all(30.0),
//             child: Container(
//                 margin: EdgeInsets.only(top: 20.0, bottom: 300),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(40.0),
//                     color: Colors.white))),
//       ),
//     );
//   }
// }
