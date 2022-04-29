  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:project_wireless/models/myuser.dart';
  import 'package:project_wireless/models/recipe.dart';


  class DatabaseService {
    final String uid;
    DatabaseService({required this.uid});

    final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipe');

    Future updateUserData(String sugars, String name, int strength) async {
      return await recipeCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });
    }
// recipe list from snapshot
    List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.docs.map((doc){
        return Recipe(
            name: doc.get('name') ?? '',
            sugars: doc.get('sugars') ?? '0',
            strength: doc.get('strength') ?? 0
        );
      }).toList();
    }

    UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
      return UserData(uid: uid, name: snapshot['name'], sugars: snapshot['sugars'], strength: snapshot['strength']);
    }

    Stream<List<Recipe>> get recipes {
      return recipeCollection.snapshots().map(_recipeListFromSnapshot);
    }

    Stream<UserData> get userData {
      return recipeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    }
  }