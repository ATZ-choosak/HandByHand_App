import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';
import 'package:hand_by_hand_app/presentation/widgets/alert_message.dart';
import 'package:hand_by_hand_app/presentation/widgets/custom_scaffold_without_scroll.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodeScaner extends StatelessWidget {
  const QrcodeScaner({super.key, required this.exchangeId});

  final int exchangeId;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithoutScroll(
      appBar: AppBar(),
      child: BlocListener<ExchangeBloc, ExchangeState>(
        listener: (context, state) {
          if (state is ExchangeOutGoingSuccess) {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (context.mounted) {
                Navigator.pop(context);
              }
            });
          }

          if (state is CheckUuidSuccess) {
            // Show alert message and navigate back
            AlertMessage.alert("แจ้งเตือน", state.message, context);
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                context.read<ExchangeBloc>().add(ExchangeOutgoingEvent());
                Navigator.pop(context);
              }
            });
          }
        },
        child: BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (context, state) {
            return Stack(
              children: [
                // Remove Expanded here
                MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                  ),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty &&
                        barcodes[0].rawValue!.isNotEmpty) {
                      context.read<ExchangeBloc>().add(CheckUuidEvent(
                            exchangeId: exchangeId,
                            exchangeUuid: barcodes[0].rawValue!,
                          ));
                    }
                  },
                ),
                if (state
                    is CheckUuidLoading) // Show loading indicator when loading
                  Container(
                    color: Colors.black54, // Semi-transparent background
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
