mainApi({String url, String params = ''}) {
  final authKey = '7190WHUt7gzKgrRURMnoS4D7tX6Xp112';
  final urlString = 'http://10.107.0.10:3000/$url?auth=$authKey$params';
  
  return urlString;
}
