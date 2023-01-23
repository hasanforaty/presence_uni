import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future showFilter(BuildContext context) =>
    showDialog(context: context, builder: (_) => const FilterDialog());

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            //TODO apply Filter chosen
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //TODO : get List of University and complete Filter page
                    FilterChip(
                        label: const Text("دانشکده علوم"), onSelected: (_) {}),
                    FilterChip(
                        label: const Text("دانشکده فرهنگ"), onSelected: (_) {}),
                    FilterChip(
                        label: const Text("دانشکده انسانی"),
                        onSelected: (_) {}),
                    FilterChip(
                        label: const Text("دانشکده فنی و حرفه ای "),
                        onSelected: (_) {}),
                    FilterChip(
                        label: const Text("دانشکده معارف"), onSelected: (_) {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
