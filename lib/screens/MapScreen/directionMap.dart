import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newwisataklu/screens/loadingScreen/loading.dart';
import 'package:newwisataklu/screens/loadingScreen/loadingGps.dart';

class DirectionMap extends StatefulWidget {
  DirectionMap({this.id, this.kind, this.subD});
  final String id;
  final String kind;
  final String subD;
  @override
  _DirectionMapState createState() => _DirectionMapState();
}

class _DirectionMapState extends State<DirectionMap> {
  bool mapToggle = false;
  bool clientToggle = false;
  var currentLocation;
  var tourisms = [];
  double lat;
  double long;

  GoogleMapController mapController;

  CameraPosition cameraPosition;

  Map<MarkerId, Marker> _markers = Map();

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
        populateClient();
      });
    });
    // print(lat);
  }

  populateClient() {
    tourisms = [];
    Firestore.instance
        .collection('Tourisms')
        .where('image', isEqualTo: widget.id)
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          clientToggle = true;
        });
        for (int i = 0; i < docs.documents.length; i++) {
          tourisms.add(docs.documents[i].data);
          initMarker(docs.documents[i].data);
        }
      }
    });
  }

  initMarker(tourim) {
    final markerId = MarkerId(tourim['name']);
    final markers = Marker(
        markerId: markerId,
        position: LatLng(tourim['lating'].latitude, tourim['lating'].longitude),
        infoWindow:
            InfoWindow(title: tourim['name'], snippet: tourim['description']));
    setState(() {
      _markers[markerId] = markers;
    });
  }

  zoomInMarker(tourim) {
    LatLng latLng =
        new LatLng(tourim['lating'].latitude, tourim['lating'].longitude);
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 17);
    mapController.animateCamera(cameraUpdate);
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Widget clientCard(tourim) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          zoomInMarker(tourim);
        },
        child: Container(
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white60),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                      height: MediaQuery.of(context).size.height - 5.0,
                      width: 130.0,
                      image: NetworkImage(tourim['image']),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 6.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          tourim['name'],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Container(
                          width: 60,
                          height: 18,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: tourim['kind'] == 'culture'
                                  ? Colors.blue
                                  : tourim['kind'] == 'natural'
                                      ? Colors.green
                                      : Colors.orange),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              tourim['kind'],
                              style: TextStyle(
                                // backgroundColor: Colors.blue,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          tourim['ticket'] == null
                              ? tourim['priceStart'].toString() +
                                  ' - ' +
                                  tourim['priceEnd'].toString()
                              : tourim['ticket'] == 0
                                  ? 'Free'
                                  : tourim['ticket'].toString() + '/ticket',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 12.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 1.0,
                            ),
                            Text(
                              tourim['subDistric'],
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2, right: 3),
                        child: Text(
                          tourim['description'],
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: mapToggle
                  ? GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(-8.3739, 116.2777), zoom: 10.0),
                      markers: Set.of(_markers.values),
                    )
                  : LoadingGps()
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 250.0,
              child: Container(
                height: 160.0,
                width: MediaQuery.of(context).size.width - 10,
                child: clientToggle
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 10),
                        children: tourisms.map((element) {
                          return clientCard(element);
                        }).toList(),
                      )
                    : Container(
                        height: 1.0,
                        width: 1.0,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
