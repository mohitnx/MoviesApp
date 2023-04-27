import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movieapp/presentation/screens/details_screen.dart';

import '../../constants.dart';

Widget popularMovies(
  BuildContext context,
  String title,
  String description,
  String image,
  int id,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  movieId: id,
                )),
      );
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: 160,
          child: Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: mainColor,
                    padding: const EdgeInsets.all(3),
                    child: const Text(
                      'HD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 160,
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 160,
          child: Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(color: secondaryTextColor, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget popularMoviesVertical(BuildContext context, String title,
    String description, String image, List genre, int id) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  movieId: id,
                )),
      );
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          child: Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: mainColor,
                    padding: const EdgeInsets.all(3),
                    child: const Text(
                      'HD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          children: [
            SizedBox(
              width: 180,
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            SizedBox(
              width: 180,
              child: Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: secondaryTextColor, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 39,
            ),

            //taking each item of list genre and returing a Text widget
            SizedBox(
              width: 180,
              //using row we got overflow...and didn't want to make such a tiny scrollable row here..not good ui i think
              child: Wrap(
                children: genre.map((var item) {
                  return Text(
                    item + ', ',
                    style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


//1
//after 'popular search' text, there is  extra space at the top befoer the list view items start 
//why?...
//ans: due to deafult padding in list veiw...to hatayechi extra space is gone


//2
//movie photo ko side ma top ma title and descirotpion...spacing then bottom ma genre list
//cant use flxe due to page layout...uta listview.builder cha...so renderbox error shown
//using two columns parent column with mainaxis aloigntmetn space betwee. 
//parent col ma chai title and descripn as one column item and anterh item chai genre
//esari title descipn top ma bascha ani genre bottom ma aucha....tara yo ni kaam garena...so aile lai manually garya cha
