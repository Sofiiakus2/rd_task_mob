import 'package:flutter/material.dart';

import '../../colors.dart';


class AnimationList extends StatefulWidget {
  const AnimationList({Key? key}) : super(key: key);

  @override
  State<AnimationList> createState() => _AnimationListState();
}

class _AnimationListState extends State<AnimationList> {
  final List<String> _items = ['Завдання 1'];
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<TextEditingController> taskWidgets = [TextEditingController()];

  void _addItem() {
    _items.insert(0, "Завдання");
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
          (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: index == taskWidgets.length - 1
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        taskWidgets.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        taskWidgets.add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              )
                  : IconButton(
                onPressed: () {
                  setState(() {
                    taskWidgets.removeAt(index);
                  });
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              hintText: 'Завдання',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: AnimatedList(
        key: _key,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.grey.withOpacity(0.3),
                  suffixIcon: index == taskWidgets.length - 1
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _removeItem(index);
                          });
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _addItem();
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  )
                      : IconButton(
                    onPressed: () {
                      setState(() {
                        _removeItem(index);
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  hintText: 'Завдання',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          );
        },
      ),);

  }

}
