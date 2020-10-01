import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CheckpointEntity extends Equatable {
  final bool pointComplete;
  final String pointId;
  final String pointName;
  final String pointLocal;
  final String pointNote;
  final String pointGroup;
}
