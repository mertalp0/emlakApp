
import 'package:flutter/material.dart';
import 'evekle.dart';
import 'musteriekle.dart';

class Ekleme extends StatefulWidget {
  const Ekleme({super.key});

  @override
  State<Ekleme> createState() => _EklemeState();
}

class _EklemeState extends State<Ekleme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Container(
              width: 1500,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
                image: DecorationImage(
                  image: const NetworkImage(
                      "https://365psd.com/images/istock/previews/9058/90581657-people-large-group.jpg"),
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 71, 62, 62).withOpacity(0.9),
                    BlendMode.modulate,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusteriEkle()),
                  );
                },
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "MÜŞTERİ EKLE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ))),
              )),
        ),
        Expanded(
          child: Container(
              width: 1500,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
                image: DecorationImage(
                  image: const NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJDXnO6hXcRyapQvGAUqm38h1rmcW8pVW0IA&usqp=CAU"),
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 71, 62, 62).withOpacity(0.9),
                    BlendMode.modulate,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EvEkle()),
                  );
                },
                child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "EV EKLE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ))),
              )),
        ),
      ]),
    );
  }
}
