import 'package:flutter_web/material.dart';
import '../data/Profile.dart';

class BodyLoading extends StatelessWidget {

    @override
    Widget build (BuildContext ctxt) {
      return Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Align( alignment: Alignment.center, 
                                  child: Container (
                                  child: new CircularProgressIndicator()
                                ) 
                  )
                )
      );
    }

}

class BodyHome extends StatelessWidget {

    final Profile profile;

    BodyHome({this.profile});

    @override
    Widget build (BuildContext ctxt) {
      return 
      Row (
        children : [
        Flexible(child: Container(), flex: 1),
        Flexible(child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderProfile(profile: profile),
                    ListDisplay(profile: profile)
                  ],
                ), 
                flex: 2),
        Flexible(child: Container(), flex: 1),
        ]
      );
    }
}

class HeaderProfile extends StatelessWidget {

    final Profile profile;

    HeaderProfile({this.profile});

    @override
    Widget build (BuildContext ctxt) {
      return  
            Padding (padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0

            Row(
              children: <Widget>[
              Text ("moisesvazquez.com",
                  style: TextStyle( fontWeight: FontWeight.bold, 
                            color: Colors.black, 
                            fontSize: 40
                            )            
              ),
              Text ("'s blog",
                  style: TextStyle( fontWeight: FontWeight.bold, 
                            color: Colors.grey, 
                            fontSize: 40
                  )            
              )]
          )
        )
      );
    }

}

class ListDisplay extends StatelessWidget {

    final Profile profile;

    ListDisplay({this.profile});

    @override
    Widget build (BuildContext ctxt) {
      return new ListView.builder (
        shrinkWrap: true,
        itemCount: this.profile.posts.length,
        itemBuilder: (BuildContext ctxt, int index) => buildItem(ctxt, index)
      );
    }

    Widget buildItem(BuildContext ctxt, int index) {
      return
      Padding (padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.posts[index].title,
              style: TextStyle( fontWeight: FontWeight.bold, 
                                color: Colors.black, 
                                fontSize: 30),
            ),
            Text(
              profile.posts[index].description,
              style: TextStyle( fontWeight: FontWeight.normal, 
                                color: Colors.grey, 
                                fontSize: 20),
            ),
          ],
        )
      );
    }
}