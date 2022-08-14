import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:string_to_hex/string_to_hex.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient Generator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Home(),
    );
  }
}

final color1Provider = StateProvider((ref) => Colors.black);
final color2Provider = StateProvider((ref) => Colors.white);
final color1TextProvider =
    StateProvider((ref) => TextEditingController(text: "000000"));
final color2TextProvider =
    StateProvider((ref) => TextEditingController(text: "ffffff"));

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gradient Generator')),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Consumer(builder: (context, ref, _) {
                    return Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller:
                                  ref.read(color1TextProvider.state).state,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                ref.read(color1Provider.state).state = Color(
                                  int.parse("0x" +
                                      "ff" +
                                      ref
                                          .read(color1TextProvider.state)
                                          .state
                                          .text),
                                );
                              },
                              child: const Text("Update Color 1"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, _) {
                      return Form(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller:
                                    ref.read(color2TextProvider.state).state,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(color2Provider.state).state = Color(
                                      int.parse("0x" +
                                          "ff" +
                                          ref
                                              .read(color2TextProvider.state)
                                              .state
                                              .text));
                                },
                                child: const Text("Update Color 2"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, _) {
                final color1 = ref.watch(color1Provider.state).state;
                final color2 = ref.watch(color2Provider.state).state;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color1, color2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
