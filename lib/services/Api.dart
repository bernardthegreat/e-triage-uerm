mainApi({String url, String params = ''}) {
  final authKey = '7190WHUt7gzKgrRURMnoS4D7tX6Xp112';
  final urlString = 'https://apps.uerm.edu.ph:3443/$url?auth=$authKey$params';
  // final urlString = 'http://10.107.4.220:3000/$url?auth=$authKey$params';
  return urlString;
}
