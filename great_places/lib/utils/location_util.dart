const GOOGLE_API_KEY = '...';

class LocationUtil {
  static String generateLocationPreviewImage(
      {double latitude = 40.718217, double longitude = -73.998284}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
