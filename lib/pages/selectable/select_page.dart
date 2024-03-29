import 'package:flutter/material.dart';
import 'package:topic_selector/controller/app_controller.dart';
import 'package:topic_selector/model/contact_model.dart';
import 'package:topic_selector/pages/selectable/selected_page.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  final controller = AppController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Search:"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22.0)),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      controller.setStartSearch(value: true);
                      controller.searchContact(
                        listToSearch: controller.contactsList,
                        pattern: value,
                      );
                    } else {
                      controller.setStartSearch(value: false);
                    }
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

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.deepOrange,
                              duration: const Duration(milliseconds: 300),
                              content: !contato.isSelected
                                  ? Text("${contato.name} Unselected")
                                  : Text("${contato.name} Selected")));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.navigate_next_rounded),
        onPressed: () {
          if (controller.selectedList.isNotEmpty) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SelectedPage(selectedList: controller.selectedList)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.deepOrange,
                duration: Duration(milliseconds: 700),
                content: Text("You must select a least one contact!")));
          }
        },
      ),
    );
  }
}
