import 'package:flutter/material.dart';

import 'package:topic_selector/model/contact_model.dart';

class SelectedPage extends StatefulWidget {
  final List<ContactModel> selectedList;

  const SelectedPage({
    Key? key,
    required this.selectedList,
  }) : super(key: key);

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          itemCount: widget.selectedList.length,
          itemBuilder: (context, index) {
            ContactModel contato = widget.selectedList[index];
            return ListTile(
              title: Text(contato.name),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.navigate_next),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
            );
          },
        ),
      ),
    );
  }
}
