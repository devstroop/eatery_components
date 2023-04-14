import 'dart:io';

import 'package:eatery_services/eatery_services.dart';
import 'package:flutter/material.dart';
import 'package:eatery_db/models/product/product.dart';
import 'package:eatery_db/eatery_db.dart';

import '../buttons/primary.button.dart';
import '../titles/page.title.dart';

class ProductInternalViewBottomsheet extends StatefulWidget {
  const ProductInternalViewBottomsheet(
      {Key? key,
      required this.product,
      this.color,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);
  final Product product;
  final Color? color;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<ProductInternalViewBottomsheet> createState() =>
      _ProductInternalViewBottomsheetState();
}

class _ProductInternalViewBottomsheetState
    extends State<ProductInternalViewBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PageTitle(
                  title: widget.product.name,
                  subtitle: widget.product.categoryId != null
                      ? EateryDB().productCategoryBox().values.singleWhere((element) => element.id == widget.product.categoryId).name
                      : 'Uncategorized'),
              Switch(
                activeColor: widget.color,
                  value: widget.product.isActive,
                  onChanged: (value) async {
                    widget.product.isActive = value;
                    await widget.product.save();
                    setState(() {});
                  })
            ],
          ),
          const SizedBox(height: 12.0),
          Expanded(
              child: Center(
            child: FutureBuilder<String>(
                future: FileServices.absImage(widget.product.image!),
                builder: (context, snapshot) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      image: snapshot.hasData &&
                              File(snapshot.data ?? '').existsSync()
                          ? DecorationImage(
                              image: FileImage(File(snapshot.data!)),
                              fit: BoxFit.cover)
                          : const DecorationImage(
                              image: AssetImage('assets/images/default.jpg'),
                              fit: BoxFit.cover),
                    ),
                  );
                }),
          )),
          const SizedBox(height: 8.0),
          if (widget.product.description != null)
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          if (widget.product.description != null)
            Text(
              widget.product.description!,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF888888),),
            ),
          if (widget.product.description != null) const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButton(
                  color: widget.color ?? const Color(0xFF30A8CF),
                  onPressed: widget.onEdit,
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              PrimaryButton(
                color: const Color(0xFFE53935),
                onPressed: widget.onDelete,
                child: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
