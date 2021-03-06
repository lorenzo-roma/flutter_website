import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_website/helpers/firestore_helper.dart';
import 'package:flutter_website/models/project.dart';

class ProjectsProvider with ChangeNotifier {
  ProjectsProvider() {
    _fecthProjects();
  }

  List<Project> _projects = [];

  List<Project> get projects {
    _projects.sort((a, b) => a.sortIndex - b.sortIndex);
    return _projects;
  }

  void _fecthProjects() async {
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection(FirestoreHelper.FIREBASE_PROJECTS_COLLECTION)
        .get();
    _querySnapshot.docs.forEach(
      (p) {
        _projects.add(FirestoreHelper.toProject(p));
      },
    );
    notifyListeners();
  }
}
