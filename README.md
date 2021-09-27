<img align="left" width="80" height="80" src="https://raw.githubusercontent.com/melwaraki/Cafewheria/main/Cafewheria/Assets.xcassets/AppIcon.appiconset/Icon-83_5%402x.png" alt="Cafewheria app icon">

# Cafewheria


An app to find your nearest coffee shop

## Please note:
> To use your own Foursquare keys, head over to Networking/Router.swift

## Development approach
The purpose of Cafewheria is to provide users with a quick way to discover nearby coffee shops. It's powered by the Foursquare API.

The goal was to make it as easy as possible for a user to get to a coffee shop. 

The app uses an MVC approach as it is suitable for a project of this size. Network calls are abstracted away from the view controllers.

Several functions are unit tested, achieving just over 50% code coverage.

## Future additions

Future updates to this app could add functionality such as an option to view more details of a venue such as images and opening hours before navigating to it.

The option to add some filtering to the "I'm Feeling Lucky" functionality was considered though due to the lack of nearby venues this could result in no available choices. It also removes the spontaneous element of the feature. Instead, it was designed to filter to only choose from nearby venues.

## Screenshots

Welcome Screen             |  List
:-------------------------:|:-------------------------:
![Welcome](Screenshots/Welcome.png)  |  ![List](Screenshots/List.png)

The app also accommodates for different states such as loading or unauthorised location access.

Loading             |  No Location Access
:-------------------------:|:-------------------------:
![Loading](Screenshots/Loading.png)  |  ![NoLocation](Screenshots/NoLocation.png)

Selecting any coffee shop will open the maps app with walking directions automatically selected. An "I'm Feeling Lucky" button takes adventurous users to a randomly selected nearby location. Only for the brave hearted!

I'm Feeling Lucky             |  Walking Directions in Maps
:-------------------------:|:-------------------------:
![Lucky](Screenshots/Lucky.png)  |  ![Maps](Screenshots/Maps.png)
