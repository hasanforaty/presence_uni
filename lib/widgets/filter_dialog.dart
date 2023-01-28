import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/bloc/attendacne_filter_bloc.dart';
import 'package:presence_absence/models/university.dart';

Future showFilter(BuildContext context) => showDialog(
    context: context, builder: (_) => FilterDialog(buildContext: context));

class FilterDialog extends StatefulWidget {
  final BuildContext buildContext;
  const FilterDialog({Key? key, required this.buildContext}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final List<University> universityFilterSelected = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var miniTextTheme = Theme.of(context).textTheme.caption;
    return AlertDialog(
      title: const Center(
        child: Text(
          "فیلتر",
        ),
      ),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      actions: [
        ActionChip(
          label: const Text("لغو"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ActionChip(
          label: const Text("اعمال"),
          onPressed: () {
            widget.buildContext
                .read<AttendanceFilterBloc>()
                .changeSelectedUni(universityFilterSelected);
            Navigator.pop(context);
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //دانشکده ها
              Text(
                "دانشکده :",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    var item = universityList[index];
                    return FilterChip(
                      label: Text(item.name),
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            universityFilterSelected.add(item);
                          } else {
                            universityFilterSelected.remove(item);
                          }
                        });
                      },
                      selected: universityFilterSelected.contains(item),
                    );
                  },
                  itemCount: universityList.length,
                ),
              ),
              for (var selected in universityFilterSelected)
                Text(
                  selected.name,
                  style: miniTextTheme,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
