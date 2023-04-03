import 'package:flutter/material.dart';
import 'package:pune_connect/src/screens/pass_details.dart';
import '../data.dart';

class PassList extends StatelessWidget {
  final List<Pass> passes;
  final ValueChanged<Pass>? onTap;

  const PassList({
    required this.passes,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        child: ListView.builder(
                itemCount: passes.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    style: const TextStyle(fontSize: 24.0),
                    passes[index].title,
                  ),
                  leading: passes[index].passIcon,
                  trailing: Text(passes[index].price.toString()),
                  onTap: () =>  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (context) {
                      return PassDetailsScreen(
                        pass: passes[index],);
                    },
                  ))
                ),
              ),
      ),
    ],
  );
}
