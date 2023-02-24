import 'package:blocstuff/bloc/ui_bloc.dart';
import 'package:blocstuff/bloc/ui_event.dart';
import 'package:blocstuff/bloc/ui_state.dart';
import 'package:blocstuff/models/item_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UiPage extends StatefulWidget {
  const UiPage({super.key});

  static List<String> itemsToChooseFrom = [
    'Osmodius',
    'Claudius',
    'Trinkau',
    'Pedri',
    'Minguesa'
  ];

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UiBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<UiBloc, UiState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    ...(state as UiInitial).items.asMap().entries.map(
                        (e) => _buildItemUiWidget(e: e.value, index: e.key)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sub total'),
                          calculateSubtotal(state.items)
                        ],
                      ),
                    ),
                    const SizedBox(height: 300)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemUiWidget({required ItemObject e, required int index}) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            labelAndField(
              label: 'Item',
              field: _buildDropDown(e),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: labelAndField(
                    label: 'Quantity',
                    field: TextField(
                      controller: e.quantityTEC,
                      keyboardType: TextInputType.number,
                      decoration: _buildTextDecoration(),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: labelAndField(
                    label: 'Rate',
                    field: TextField(
                      controller: e.rateTEC,
                      keyboardType: TextInputType.number,
                      decoration: _buildTextDecoration(),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                buildTotalDisplayWidget(
                  total: e.total,
                  onRemove: () {
                    BlocProvider.of<UiBloc>(context)
                        .add(RemoveItem(index: index));
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                BlocProvider.of<UiBloc>(context).add(AddItem());
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.add_box_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add more',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildDropDown(ItemObject e) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade500)),
      width: double.infinity,
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        value: e.item,
        items: UiPage.itemsToChooseFrom
            .map((i) => DropdownMenuItem(
                  value: i,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(i),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            e.item = value;
          });
        },
        borderRadius: BorderRadius.circular(5),
      )),
    );
  }

  Widget labelAndField({required String label, required Widget field}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        SizedBox(height: 40, child: field)
      ],
    );
  }

  InputDecoration _buildTextDecoration() {
    final inputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.grey.shade500));

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
    );
  }

  Widget buildTotalDisplayWidget(
      {required double total, required Function() onRemove}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 40,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$total'),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.clear),
              // visualDensity: VisualDensity.compact,
            )
          ],
        ),
      ),
    );
  }

  calculateSubtotal(List<ItemObject> items) {
    double subtotal = 0;
    for (final i in items) {
      subtotal += i.total;
    }
    return Text('NGN $subtotal');
  }
}
