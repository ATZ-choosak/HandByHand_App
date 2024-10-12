import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';

abstract class ItemRepository {
  Future<Either> addItem(AddItemEvent addItemReq, List<File> images);

  Future<Either<String, GetAllItemModel>> getItem(GetItemEvent getItemReq);
}
