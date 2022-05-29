class Category {
  final String title;
  final String url;
  final String type;

  Category(this.title, this.url, this.type);
}

List<Category> iconList = [
  Category(
      'Unprescribed Drugs',
      'https://www.nhathuocankhang.com/images/newversion/home/icon_Thuoc.png',
      'A1'),
  Category(
      'Medical Equipment',
      'https://www.nhathuocankhang.com/images/newversion/home/icon_TPCN.png',
      'A2'),
  Category(
      'Prescription Picture',
      'https://www.nhathuocankhang.com/images/newversion/home/icon_DDYT.png',
      'camera'),
  Category(
      'Cosmetics',
      'https://www.nhathuocankhang.com/images/newversion/home/icon_Mypham.png',
      'A4'),
  Category(
      'Personal Care',
      'https://www.nhathuocankhang.com/images/newversion/home/icon_CSCC.png',
      'A5'),
];
