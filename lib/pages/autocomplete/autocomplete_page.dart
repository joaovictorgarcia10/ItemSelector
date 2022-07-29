import 'package:flutter/material.dart';
import 'package:topic_selector/model/contact_model.dart';
import '../../controller/app_controller.dart';

class AutocompletePage extends StatefulWidget {
  const AutocompletePage({Key? key}) : super(key: key);

  @override
  State<AutocompletePage> createState() => _AutocompletePageState();
}

class _AutocompletePageState extends State<AutocompletePage> {
  final controller = AppController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Auto Complete")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Column(
              children: [
                Autocomplete<String>(
                  optionsBuilder: (textEditingValue) {
                    List<String> contactNameList = [];
                    if (textEditingValue.text.isEmpty) {
                      controller.setStartSearch(value: false);
                      return contactNameList;
                    } else {
                      for (var contact in controller.contactsList) {
                        contactNameList.add(contact.name);
                      }

                      controller.setStartSearch(value: true);
                      controller.searchContact(
                        listToSearch: controller.contactsList,
                        pattern: textEditingValue.text,
                      );

                      return contactNameList.where((contact) => contact
                          .toLowerCase()
                          .contains(textEditingValue.text));
                    }
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10.0),
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return ListTile(
                              title: Text(option.toString()),
                              onTap: () => onSelected(option),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    );
                  },
                  fieldViewBuilder: (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        label: Text("Search:"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50.0),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: controller.startSearch
                        ? controller.searchList.length
                        : controller.contactsList.length,
                    itemBuilder: (context, index) {
                      ContactModel contato = controller.startSearch
                          ? controller.searchList[index]
                          : controller.contactsList[index];

                      return InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: !contato.isSelected
                                ? Colors.transparent
                                : Colors.deepOrange,
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          child: Center(child: Text(contato.name)),
                        ),
                        borderRadius: BorderRadius.circular(22.0),
                        onTap: () {
                          controller.selectContact(contato: contato);
                        },
                      );
                    },
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
