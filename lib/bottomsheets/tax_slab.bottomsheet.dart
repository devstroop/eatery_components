import 'package:eatery_components/buttons/primary.button.dart';
import 'package:eatery_components/titles/page.title.dart';
import 'package:flutter/material.dart';
import 'package:eatery_db/models/tax/tax_slab.dart';

class TaxSlabBottomsheet extends StatelessWidget {
  const TaxSlabBottomsheet(
      {Key? key,
      required this.taxSlab,
      this.color,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);
  final TaxSlab taxSlab;
  final Color? color;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          PageTitle(title: taxSlab.name, subtitle: taxSlab.type.name),
          Expanded(
              child: Center(
            child: CircleAvatar(
              radius: 96,
              backgroundColor: color ?? const Color(0xFF30A8CF),
              child: Text('${taxSlab.rate}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 36,
                    color: Colors.white,
                  )),
            ),
          )),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButton(
                  color: color ?? const Color(0xFF30A8CF),
                  onPressed: onEdit,
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              PrimaryButton(
                color: const Color(0xFFE53935),
                onPressed: onDelete,
                child: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
