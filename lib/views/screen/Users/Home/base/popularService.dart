
import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
import 'package:naibrly/views/base/Ios_effect/iosTapEffect.dart';
import 'package:naibrly/views/screen/Users/Home/details/details__screen.dart';
class Popularservice extends StatelessWidget {
  Popularservice({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: item.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          final items= item[index];
          
          return IosTapEffect(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen()));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.White,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.06),
                    offset: Offset(0, 1),
                    blurRadius: 15,
                  )
                ],
                border: Border.all(
                  width: 0.8,
                  color: Color(0xFF000000).withOpacity(0.10),
                )
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(items['image'],height: 60,width: 80,fit: BoxFit.cover,)),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(items['title'],color: AppColors.black,fontSize: 16,fontWeight: FontWeight.bold,),
                      SizedBox(height: 5,),
                      RichText(
                        text: TextSpan(
                          text: "Avg. price: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: "\$${items['miniPrice']} - \$${items['maxPrice']}",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          );

    });
  }
  final List<Map<String,dynamic>> item =[
    {
      "title": "Appliance Repairs",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/2e3930c1aab5b2c6dde558ff503fc369910bcaa4.png",
    },
    {
      "title": "Furnace Repairs",
      "miniPrice":"90",
      "maxPrice":"100",
      "image":"assets/images/4d3edabcc092df3d13966845ee3b73bd6ff825b4.png",
    },
    {
      "title": "House Cleaning Service",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/603a0fe0244b11a44a31af4acf8fa37fbad3645d.png",
    },
    {
      "title": "Handyman",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/d8e764035c9b310d163aa424e5b91e7f2a66a150.png",
    },
    {
      "title": "Windows & Doors",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/1053bba3a6867cd904dc50991d81665af7682796.png",
    },
    {
      "title": "Locksmiths",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/d8e764035c9b310d163aa424e5b91e7f2a66a150.png",
    },
    {
      "title": "Plumbing",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/e0a5051b9af8512d821599ee993492a9954bb256.png",
    },
    {
      "title": "Car Repairs",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/2e3930c1aab5b2c6dde558ff503fc369910bcaa4.png",
    },
    {
      "title": "Machine Repairs",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/1053bba3a6867cd904dc50991d81665af7682796.png",
    },
    {
      "title": "Computer",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/603a0fe0244b11a44a31af4acf8fa37fbad3645d.png",
    },
    {
      "title": "Betters then",
      "miniPrice":"100",
      "maxPrice":"120",
      "image":"assets/images/2e3930c1aab5b2c6dde558ff503fc369910bcaa4.png",
    },
  ];
}
