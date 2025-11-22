// import 'package:get_storage/get_storage.dart';
//
// class StorageService {
//   final GetStorage _box = GetStorage();
//
//   Future<void> initStorage() async {
//     await GetStorage.init();
//   }
//
//   // Write data to storage
//   Future<void> write(String key, dynamic value) async {
//     await _box.write(key, value);
//   }
//
//   // Read data from storage
//   T? read<T>(String key) {
//     return _box.read<T>(key);
//   }
//
//   // Remove data from storage
//   Future<void> remove(String key) async {
//     await _box.remove(key);
//   }
//
//   // Clear all data from storage
//   Future<void> clear() async {
//     await _box.erase();
//   }
// }