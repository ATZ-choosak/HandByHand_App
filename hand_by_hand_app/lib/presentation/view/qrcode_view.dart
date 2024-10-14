import 'package:flutter/material.dart';
import 'package:hand_by_hand_app/data/models/exchange/exchange_model.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeView extends StatelessWidget {
  const QrcodeView({super.key, required this.exchange});

  final ExchangeInComing exchange;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithoutScroll(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(exchange.requestedItem.name),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(50),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.yellow.shade600, Colors.green.shade600])),
              child: Container(
                color: Colors.white,
                child: QrImageView(
                  data: exchange.exchangeUuid,
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
            ),
          ),
        ));
  }
}
