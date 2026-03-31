import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dish_model.dart';

class MenuService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of all dishes
  Stream<List<DishModel>> getDishes() {
    return _db.collection('menu_items').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DishModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Get dishes by category
  Future<List<DishModel>> getDishesByCategory(String category) async {
    var snapshot = await _db
        .collection('menu_items')
        .where('category', isEqualTo: category)
        .get();
    
    return snapshot.docs.map((doc) {
      return DishModel.fromFirestore(doc.data(), doc.id);
    }).toList();
  }

  // Get single dish by ID
  Future<DishModel?> getDishById(String id) async {
    var doc = await _db.collection('menu_items').doc(id).get();
    if (doc.exists) {
      return DishModel.fromFirestore(doc.data()!, doc.id);
    }
    return null;
  }
}
