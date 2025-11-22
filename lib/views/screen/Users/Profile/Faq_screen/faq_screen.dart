import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naibrly/views/screen/Users/Profile/support/support_screen.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/AppText/appText.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.White,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: AppColors.White,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              "assets/icons/icon/arrow-left.svg",
              color: Colors.black,
              width: 24,
              height: 24,
            ),
          ),

          title: AppText(
            "FAQ",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.Black,
          ),
          centerTitle: true,
        ),

        body: Padding(
          padding: EdgeInsets.only(left: 0, right: 0, top: 0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "At Viral Pitch, we expect at a day’s start is you, better and happier than yesterday. Or check our frequently asked questions listed below.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Detailed answer about how to apply for a campaign will go here.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Here is another explanation of the process to apply for a campaign.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Here is another explanation of the process to apply for a campaign.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Here is another explanation of the process to apply for a campaign.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Here is another explanation of the process to apply for a campaign.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Here is another explanation of the process to apply for a campaign.",
              ),
              FAQItem(
                question: "How to apply for a campaign?",
                answer: "Here is another explanation of the process to apply for a campaign.",
              ),

              SizedBox(height: 35),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: (){
                  ///  Get.to(SupportsScreen());
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SupportsScreen()));

                  },
                  child: AppText(
                    "Contract Support",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.Black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 35),

            ],
          ),
        )
    );
  }
}


class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false; //------ Track expansion state --------//

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //------- GestureDetector to handle tapping -------//
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded; // Toggle expansion
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    widget.question,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF01010B)
                ),
                Icon(
                  _isExpanded ? Icons.remove : Icons.add,
                  color: Color(0xFF01010B),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        //------ AnimatedContainer to expand and collapse content ------//
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.only(left: 24, right: 24, top: 0),
          height: _isExpanded ? null : 0,
          child: _isExpanded
              ? Column(
            children: [
              SizedBox(height: 10),
              AppText(
                widget.answer,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF5B5B5F),
              ),
            ],
          )
              : SizedBox.shrink(),
        ),
        SizedBox(height: 10),
        //------- Divider after the item -------//
        Container(
          margin: EdgeInsets.symmetric(horizontal:20),
          height: 1,
          color: AppColors.LightGray,
        )
      ],
    );
  }
}