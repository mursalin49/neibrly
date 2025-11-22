import 'package:flutter/material.dart';
import 'contact_support_screen.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqItems = [
    {
      'question': 'How to apply for a campaign?',
      'answer': 'At Viral Pitch we expect at a day\'s start is you, better and happier than yesterday. or check our frequently asked questions listed below.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'To apply for a campaign, navigate to the campaigns section, select your desired campaign, and click the apply button. Make sure your profile is complete before applying.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'You can apply for campaigns by browsing through available opportunities in the app, selecting the one that matches your skills, and submitting your application with required documents.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'Start by creating a comprehensive profile, then explore campaign listings, read requirements carefully, and submit your application with all necessary materials.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'At Viral Pitch we expect at a day\'s start is you, better and happier than yesterday. or check our frequently asked questions listed below.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'The application process involves selecting a campaign, reviewing requirements, preparing your portfolio, and submitting your application through our platform.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'Make sure your profile is up-to-date, browse available campaigns, read the brief thoroughly, and submit your application with relevant work samples.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'To successfully apply, ensure you meet the campaign requirements, have a strong portfolio ready, and submit your application before the deadline.'
    },
    {
      'question': 'How to apply for a campaign?',
      'answer': 'Navigate to campaigns, filter by your interests, review campaign details, prepare your submission materials, and apply through our streamlined process.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "FAQ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // FAQ List
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                final isExpanded = expandedIndex == index;
                return _buildFAQItem(
                  faqItems[index]['question']!,
                  faqItems[index]['answer']!,
                  isExpanded,
                  index,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactSupportScreen(),
                  ),
                );
              },
              child: const Text(
                "Contact Support",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, bool isExpanded, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedIndex = isExpanded ? null : index;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                      color: isExpanded ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
        if (index < faqItems.length - 1)
          Divider(
            color: Colors.grey[300],
            height: 1,
          ),
      ],
    );
  }
}
