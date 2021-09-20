import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  List<String> items = ["TEST1", "TEST2", "TEST3", "TEST4", "TEST5"];
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: items.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
              width: 300,
              color: Colors.pink,
              child: Center(child: Text(items[itemIndex])),
            ),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  flex: 1,
                  child: InkWell(child: Icon(Icons.arrow_back_ios_outlined), onTap: (){
                    buttonCarouselController.previousPage(
                        duration: Duration(milliseconds: 300), curve: Curves.linear);
                  },),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  flex: 1,
                  child: InkWell(child: Icon(Icons.arrow_forward_ios_outlined), onTap: (){
                    buttonCarouselController.nextPage(
                        duration: Duration(milliseconds: 300), curve: Curves.linear);
                  },),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
