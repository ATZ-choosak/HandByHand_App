import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/presentation/bloc/my_item_bloc/bloc/my_item_bloc.dart';

abstract class MyItemRepository {
  Future<Either<String, GetAllMyItemModel>> getMyItem();
  Future<Either> deleteItem(DeleteMyItemEvent deleteItemReq);
}
