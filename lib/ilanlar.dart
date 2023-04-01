// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'güncelevbilgileri.dart';

class Ilanlar extends StatefulWidget {
  const Ilanlar({super.key});

  @override
  State<Ilanlar> createState() => _IlanlarState();
}

class _IlanlarState extends State<Ilanlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: evler.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0), width: 2)),
              height: 400,
              child: Column(children: [
                Expanded(
                    flex: 3,
                    child: Row(children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: PageView(
                          children: [
                            Image(
                              image: NetworkImage(
                                "${evler[index]["img1"]}",
                              ),
                              fit: BoxFit.cover,
                            ),
                            Image(
                              image: NetworkImage(
                                "${evler[index]["img2"]}",
                              ),
                              fit: BoxFit.cover,
                            ),
                            Image(
                              image: NetworkImage(
                                "${evler[index]["img3"]}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Column(children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 0, left: 0),
                          child: Image(
                            image: NetworkImage(
                              "${evler[index]["img4"]}",
                            ),
                            fit: BoxFit.cover,
                          ),
                        )),
                        Expanded(
                            child: Image(
                          image: NetworkImage(
                            "${evler[index]["img5"]}",
                          ),
                          fit: BoxFit.cover,
                        ))
                      ]))
                    ])),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(children: [
                        Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  evler[index]["konum"] +
                                      "'da " +
                                      evler[index]["oda"] +
                                      " " +
                                      evler[index]["tip"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("konum : " +
                                              evler[index]["konum"]),
                                          Text('fiyat : ' +
                                              evler[index]['fiyat']),
                                          Text("metrekare : " +
                                              evler[index]["metrekare"]),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("durum : " +
                                              evler[index]["durum"]),
                                          Text("otopark : " +
                                              evler[index]["otopark"]),
                                          Text("oda : " + evler[index]["oda"]),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: const ButtonStyle(),
                              child: const Text("Detay"),
                              onPressed: () {},
                            ))
                      ]),
                    )),
              ]),
            ),
          );
        },
      ),
    );
  }
}
