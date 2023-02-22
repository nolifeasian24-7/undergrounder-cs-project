import 'package:flutter/material.dart';
import 'package:undergrounder/API_service/api_service.dart';
import 'package:undergrounder/LineStatusess/DistrictStatus.dart';

import 'package:undergrounder/app_bar.dart';


class horizontalBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App_bar(
      title: "more options",
      showGoBack: true, //implementation of hamburger menu
    );
  }
}
class NavDrawer extends StatelessWidget { //navigation menu drawer class
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Side menu", style: TextStyle(color: Colors.black, fontSize: 25),),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/roundel.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text("toggle"),
            onTap: () => {},
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('District line'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['District'], 0, api: TflApi(),))), //calling function responsible for http requests with parameters
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Central line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Central'], 1, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Northern line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Northern'], 2, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Jubilee line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Jubilee'], 3, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Picadilly line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Piccadilly'], 4, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Bakerloo line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Bakerloo'], 5, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Hammersmith & City line'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['hammersmith-city'], 6, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Circle line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Circle'], 7, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Metropolitan line'),
              onTap:  ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Metropolitan'], 8, api: TflApi(),))),
          ),
          ListTile(
              leading: Icon(Icons.train),
              title: Text('Elizabeth Line'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StatusIndicator(['Elizabeth'],9,  api: TflApi(),))),
          ),
        ],
      ),
    );
  }
}
