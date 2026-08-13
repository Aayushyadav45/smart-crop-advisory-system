import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _language = 'en'; // 'en' or 'hi'
  int _currentIndex = 0;
  String _farmerName = 'Kisan';
  String? _profileImagePath;

  String get language => _language;
  int get currentIndex => _currentIndex;
  String get farmerName => _farmerName;
  String? get profileImagePath => _profileImagePath;

  void setLanguage(String langCode) {
    _language = langCode;
    notifyListeners();
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void setFarmerName(String name) {
    _farmerName = name;
    notifyListeners();
  }

  void setProfileImagePath(String path) {
    _profileImagePath = path;
    notifyListeners();
  }

  // Basic Localization Dictionary
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Smart Crop Advisory',
      'select_language': 'Select your language',
      'namaste': 'Namaste, Farmer',
      'tap_to_scan': 'Tap to scan a leaf',
      'weather': 'Weather',
      'weather_desc': '28°C, clear',
      'schemes': 'Schemes',
      'schemes_desc': '3 available',
      'recent_scans': 'Recent scans',
      'scan_leaf': 'Scan leaf',
      'camera_preview': 'Camera preview',
      'choose_gallery': 'Or choose from gallery',
      'diagnosis': 'Diagnosis',
      'leaf_photo': 'Leaf photo',
      'tomato_blight': 'Tomato - Early Blight',
      'confidence': 'Confidence: 94%',
      'remedy': 'Remedy',
      'remedy_desc': 'Apply fungicide, remove affected leaves...',
      'profile': 'Profile',
      'farmer_name': 'Farmer Name',
      'farm_details': 'Farm details',
      'notification_settings': 'Notification settings',
      'help_support': 'Help and support',
      'history': 'History',
      'advisory': 'Advisory',
      'lang': 'Language',
    },
    'hi': {
      'app_title': 'स्मार्ट फसल सलाहकार',
      'select_language': 'अपनी भाषा चुनें',
      'namaste': 'नमस्ते, किसान',
      'tap_to_scan': 'पत्ती स्कैन करने के लिए टैप करें',
      'weather': 'मौसम',
      'weather_desc': '28°C, साफ',
      'schemes': 'योजनाएं',
      'schemes_desc': '3 उपलब्ध',
      'recent_scans': 'हाल के स्कैन',
      'scan_leaf': 'पत्ती स्कैन करें',
      'camera_preview': 'कैमरा पूर्वावलोकन',
      'choose_gallery': 'या गैलरी से चुनें',
      'diagnosis': 'निदान',
      'leaf_photo': 'पत्ती की तस्वीर',
      'tomato_blight': 'टमाटर - अगेती झुलसा',
      'confidence': 'आत्मविश्वास: 94%',
      'remedy': 'उपाय',
      'remedy_desc': 'कवकनाशी लागू करें, प्रभावित पत्तियों को हटा दें...',
      'profile': 'प्रोफ़ाइल',
      'farmer_name': 'किसान का नाम',
      'farm_details': 'खेत का विवरण',
      'notification_settings': 'अधिसूचना सेटिंग्स',
      'help_support': 'सहायता और समर्थन',
      'history': 'इतिहास',
      'advisory': 'सलाहकार',
      'lang': 'भाषा',
    }
  };

  String t(String key) {
    return _localizedValues[_language]?[key] ?? key;
  }
}
