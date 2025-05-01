import '../../../core/exports.dart';
import '../../lawyer/home_lawyer/data/model/specialist_model.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<Speciality> items;
  final String title;
  final List<Speciality> selectedItems;
  final ValueChanged<List<Speciality>> onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.title,
    required this.selectedItems,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<Speciality> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = widget.selectedItems;
  }

  void _showMultiSelectDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: widget.items.map((item) {
                return CheckboxListTile(
                  value: _tempSelectedItems.contains(item),
                  title: Text(item.title ?? ''),
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked == true) {
                        _tempSelectedItems.add(item);
                      } else {
                        _tempSelectedItems.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                widget.onSelectionChanged(_tempSelectedItems);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tempSelectedItems.isEmpty
                ? Text(
                    "Select ${widget.title}",
                    style: const TextStyle(fontSize: 16.0),
                  )
                : Row(
                    children: [
                      ..._tempSelectedItems.map((e) {
                        return Text(
                          e.title ?? '',
                          style: const TextStyle(fontSize: 16.0),
                        );
                      })
                    ],
                  ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
