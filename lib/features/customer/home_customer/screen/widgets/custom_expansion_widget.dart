import '../../../../../core/exports.dart';

typedef ItemSelectedCallback<T> = void Function(T selectedItem);

class CustomerExpandableSection<T> extends StatefulWidget {
  final String title; // Section title
  final List<T> items; // List of selectable items
  final T? selectedItem; // Currently selected item
  final ItemSelectedCallback<T> onItemSelected; // Callback for item selection
  final Color? backgroundColor; // Optional background color
  final EdgeInsets contentPadding; // Content padding
  bool isExpanded;
  final String Function(T) titleExtractor; // Extracts title from T
  final String Function(T) idExtractor; // Extracts ID from T

  CustomerExpandableSection({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.titleExtractor,
    required this.idExtractor,
    this.backgroundColor,
    this.isExpanded = false,
    this.contentPadding = const EdgeInsets.all(16.0),
  });

  @override
  State<CustomerExpandableSection<T>> createState() =>
      _CustomerExpandableSectionState<T>();
}

class _CustomerExpandableSectionState<T>
    extends State<CustomerExpandableSection<T>> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      color: widget.backgroundColor ?? Colors.white,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              widget.isExpanded = value;
            });
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            widget.title,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: SvgPicture.asset(
            widget.isExpanded
                ? 'assets/icons/remove.svg'
                : 'assets/icons/add.svg',
          ),
          children: [
            Padding(
              padding: widget.contentPadding,
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  ...widget.items.map((item) {
                    return GestureDetector(
                      onTap: () {
                        widget.onItemSelected(item);
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 8.0.w),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 8.0),
                              child: SvgPicture.asset(
                                widget.selectedItem != null &&
                                        widget.idExtractor(
                                                widget.selectedItem as T) ==
                                            widget.idExtractor(item)
                                    ? 'assets/icons/rectangle_done.svg'
                                    : 'assets/icons/rectangle.svg',
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.titleExtractor(item),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
