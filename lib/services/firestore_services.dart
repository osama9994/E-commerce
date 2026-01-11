import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreServices {
  // Singleton
  FirestoreServices._();
  static final FirestoreServices instance = FirestoreServices._();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// -------------------------------
  /// Set data
  /// -------------------------------
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    debugPrint('setData: $path => $data');
    await reference.set(data);
  }

  /// -------------------------------
  /// Update data
  /// -------------------------------
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    debugPrint('updateData: $path => $data');
    await reference.update(data);
  }

  /// -------------------------------
  /// Delete data
  /// -------------------------------
  Future<void> deleteData({
    required String path,
  }) async {
    final reference = firestore.doc(path);
    debugPrint('deleteData: $path');
    await reference.delete();
  }

  /// -------------------------------
  /// GET single document (one-time)
  /// -------------------------------
  Future<T?> getDocument<T>({
    required String path, // collection/documentId
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final reference = firestore.doc(path);
    final snapshot = await reference.get();

    if (!snapshot.exists) return null;

    return builder(
      snapshot.data() as Map<String, dynamic>,
      snapshot.id,
    );
  }

  /// -------------------------------
  /// GET collection (one-time)
  /// -------------------------------
  Future<List<T>> getCollection<T>({
    required String path, // collection
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = firestore.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshot = await query.get();

    final result = snapshot.docs
        .map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    if (sort != null) {
      result.sort(sort);
    }

    return result;
  }

  /// -------------------------------
  /// Collection stream
  /// -------------------------------
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = firestore.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    final snapshots = query.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      if (sort != null) {
        result.sort(sort);
      }

      return result;
    });
  }

  /// -------------------------------
  /// Document stream
  /// -------------------------------
  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    final reference = firestore.doc(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) {
      return builder(
        snapshot.data() as Map<String, dynamic>,
        snapshot.id,
      );
    });
  }
}
