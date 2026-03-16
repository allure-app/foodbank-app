import 'package:flutter/material.dart';

class FbListView<T> extends StatelessWidget {
  const FbListView({
    super.key,
    required this.items,
    required this.idSelector,
    required this.itemBuilder,
    required this.onDelete,
    required this.onEdit,
  });

  final List<T> items;
  final int Function(T item) idSelector;
  final Function(BuildContext context, T item) itemBuilder;
  final Future<bool> Function(T item) onDelete;
  final Future<void> Function(T item) onEdit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final colours = Theme.of(context).colorScheme;
        final item = items[index];
        final id = idSelector(item);

        return Dismissible(
          key: ValueKey<int>(id),
          direction: DismissDirection.endToStart,
          background: _DismissableContainer(
            colour: colours.error,
            inverseColour: colours.onError,
            label: 'Delete',
            icon: Icons.delete_forever,
            isOnRight: true,
          ),
          confirmDismiss: (direction) async {
            final result = await onDelete(item);
            return result;
          },
          child: ListTile(
            title: itemBuilder(context, item),
            onTap: () async => await onEdit(item),
          ),
        );
      },
    );
  }
}

class _DismissableContainer extends StatelessWidget {
  const _DismissableContainer({
    required this.colour,
    required this.inverseColour,
    required this.label,
    required this.icon,
    this.isOnRight = false,
  });

  final Color colour;
  final Color inverseColour;
  final String label;
  final IconData icon;
  final bool isOnRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colour,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isOnRight
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: inverseColour)),
          const SizedBox(width: 8.0),
          Icon(Icons.edit, color: inverseColour),
        ],
      ),
    );
  }
}