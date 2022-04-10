  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:project_wireless/models/myuser.dart';
  import 'package:project_wireless/models/recipe.dart';


  class DatabaseService {
    final String uid;
    DatabaseService({required this.uid});

    final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipe');

    Future updateUserData(String sugars, String name, int rating) async {
      return await recipeCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'rating': rating,
      });
    }

    List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.docs.map((doc){
        return Recipe(
            name: doc.get('name') ?? '',
            sugars: doc.get('sugars') ?? '0',
            rating: doc.get('rating') ?? 0
        );
      }).toList();
    }

    UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
      return UserData(uid: uid, name: snapshot['name'], sugars: snapshot['sugars'], rating: snapshot['rating']);
    }

    Stream<List<Recipe>> get recipes {
      return recipeCollection.snapshots().map(_recipeListFromSnapshot);
    }

    Stream<UserData> get userData {
      return recipeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    }
  }