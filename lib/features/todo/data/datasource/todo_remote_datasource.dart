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

    final result = await collection.document(uid).get();

    final data = result.data['todos'];

    return List.generate(data.length, (index) {
      return TODOGroupModel.fromJson(data[index]);
    });
  }

  @override
  Future<void> updateCurrentTODO(List<TODOGroupModel> todogModel,
      {String uid}) async {
    final CollectionReference collection = firestore.collection('todo');

    return await collection
        .document(uid)
        .setData({'todos': todogModel.map((val) => val.toJson()).toList()});
  }
}
