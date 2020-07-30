import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';

class IOSPicker extends StatefulWidget {
  @override
  _IOSPickerState createState() => _IOSPickerState();
}

class _IOSPickerState extends State<IOSPicker> {
  CupertinoPicker getCupertinoPicker() {
    List<Text> pickerItems = [];
    for (String currencies in currenciesList) {
      pickerItems.add(Text(currencies));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getCupertinoPicker();
  }
}
