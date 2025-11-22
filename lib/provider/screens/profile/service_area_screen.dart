import 'package:flutter/material.dart';

class ServiceAreaScreen extends StatefulWidget {
  const ServiceAreaScreen({super.key});

  @override
  State<ServiceAreaScreen> createState() => _ServiceAreaScreenState();
}

class _ServiceAreaScreenState extends State<ServiceAreaScreen> {
  final TextEditingController _zipCodeController = TextEditingController();
  List<String> _suggestions = [];
  List<Map<String, String>> _selectedAreas = [];
  bool _showSuggestions = false;

  // Sample zip codes and cities data
  final List<Map<String, String>> _zipCodeData = [
    {'zip': '62704', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62703', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62705', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62701', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62702', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62706', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62707', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62708', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62709', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62710', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62711', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62712', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62715', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62716', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62719', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62722', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62723', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62726', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62736', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62739', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62746', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62756', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62757', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62761', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62762', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62763', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62764', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62765', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62766', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62767', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62769', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62777', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62781', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62786', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62791', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62794', 'city': 'Springfield', 'state': 'IL'},
    {'zip': '62796', 'city': 'Springfield', 'state': 'IL'},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with existing service areas
    _selectedAreas = [
      {'zip': '62704', 'city': 'Springfield', 'state': 'IL'},
      {'zip': '62703', 'city': 'Springfield', 'state': 'IL'},
      {'zip': '62705', 'city': 'Springfield', 'state': 'IL'},
    ];
  }

  @override
  void dispose() {
    _zipCodeController.dispose();
    super.dispose();
  }

  void _onZipCodeChanged(String value) {
    if (value.length >= 2) {
      setState(() {
        _suggestions = _zipCodeData
            .where((item) => item['zip']!.startsWith(value))
            .map((item) => '${item['zip']} - ${item['city']}, ${item['state']}')
            .take(5)
            .toList();
        _showSuggestions = _suggestions.isNotEmpty;
      });
    } else {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
    }
  }

  void _selectZipCode(String suggestion) {
    final parts = suggestion.split(' - ');
    final zip = parts[0];
    final cityState = parts[1].split(', ');
    
    final newArea = {
      'zip': zip,
      'city': cityState[0],
      'state': cityState[1],
    };

    if (!_selectedAreas.any((area) => area['zip'] == zip)) {
      setState(() {
        _selectedAreas.add(newArea);
        _zipCodeController.clear();
        _showSuggestions = false;
      });
    }
  }

  void _removeArea(Map<String, String> area) {
    setState(() {
      _selectedAreas.removeWhere((item) => item['zip'] == area['zip']);
    });
  }

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
          "Service Area",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Save changes and go back
              Navigator.pop(context);
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Color(0xFF0E7A60),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Zip Code Input Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Service Area",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _zipCodeController,
                    onChanged: _onZipCodeChanged,
                    decoration: InputDecoration(
                      hintText: "Enter zip code",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0E7A60)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  
                  // Suggestions Dropdown
                  if (_showSuggestions)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: _suggestions.map((suggestion) {
                          return ListTile(
                            title: Text(
                              suggestion,
                              style: const TextStyle(fontSize: 14),
                            ),
                            onTap: () => _selectZipCode(suggestion),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),

            // Selected Areas List
            if (_selectedAreas.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selected Service Areas",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedAreas.map((area) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E7A60),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${area['zip']} - ${area['city']}, ${area['state']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _removeArea(area),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

            // Simple Map Representation
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  // Map Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Service Coverage Map",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Map Content
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Service Areas: ${_selectedAreas.length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Coverage includes Springfield, IL",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0E7A60).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF0E7A60).withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              "Green areas indicate your service coverage",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
