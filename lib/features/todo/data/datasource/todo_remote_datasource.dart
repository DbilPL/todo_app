import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';

abstract class TODORemoteDatasource {
  /// Use [Firestore] to get current [TODO] list
  /// Returns [TODOGroupModel], if success, returns [FirebaseException] when something went wrong
  Future<List<TODOGroupModel>> getCurrentTODO();

  /// Use [Firestore] to set [TODO] list
  /// Returns [FirebaseException] when something went wrong
  Future<void> updateCurrentTODO(List<TODOGroupModel> todogModel);
}

class TodoRemoteDatasourceImpl extends TODORemoteDatasource {
  final Firestore firestore;

  TodoRemoteDatasourceImpl(this.firestore);

  @override
  Future<List<TODOGroupModel>> getCurrentTODO({String uid}) async {
    final CollectionReference collection = firestore.collection('todo');

    final docRef = collection.document(uid);

    final document = await docRef.get();

    final data = document.data['todos'];

    return List.generate(data.length as int, (index) {
      final map = data[index] as Map<String, dynamic>;

      return TODOGroupModel.fromJson(map);
    });
  }

  @override
  Future<void> updateCurrentTODO(List<TODOGroupModel> todogModel,
      {String uid}) async {
    final CollectionReference collection = firestore.collection('todo');

    final docRef = collection.document(uid);

    final data = {
      'todos': todogModel.map((val) => val.toJson()).toList(),
    };

    return docRef.setData(data);
  }
}
