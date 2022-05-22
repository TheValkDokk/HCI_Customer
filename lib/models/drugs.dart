// ignore_for_file: public_member_api_docs, sort_constructors_first
class Drug {
  String title;
  String fullName;
  String id;
  String unit;
  double price;
  String imgUrl;
  String type;
  String ingredients;
  String uses;
  double rating;
  int brought;
  Drug({
    required this.title,
    required this.fullName,
    required this.id,
    required this.unit,
    required this.price,
    required this.imgUrl,
    required this.type,
    required this.ingredients,
    required this.uses,
    required this.rating,
    required this.brought,
  });

  @override
  String toString() {
    return 'Drug(title: $title, id: $id, unit: $unit, price: $price, imgUrl: $imgUrl)';
  }
}

final List<Drug> listDrug = [
  Drug(
    brought: 50,
    rating: 4.5,
    fullName:
        'Tiffy Syrup chai 30ml siro trị các triệu chứng cảm cúm cho trẻ em',
    title: 'Tiffy Syrup trị cảm cúm cho trẻ em',
    id: 'D01',
    unit: 'Chai',
    price: 16.000,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/10022/152738/tiffy-syrup-30ml-hinh-2-700x467.jpg',
    type: 'A1',
  ),
  Drug(
    brought: 200,
    rating: 4.1,
    title: 'Coldacmin Flu trị cảm lạnh, cảm cúm',
    fullName:
        'Coldacmin Flu hộp 100 viên trị các triệu chứng cảm lạnh, cảm cúm',
    id: 'D02',
    unit: 'hộp',
    price: 30.000,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    imgUrl:
        'https://product.hstatic.net/1000113261/product/thuoc-ba-ty_b49c883dbbec44468f6cbd739ac6dcd8.jpg',
    type: 'A1',
  ),
  Drug(
    brought: 125,
    rating: 3.5,
    title: 'Soscough trị ho họng và phế quản',
    fullName:
        'Soscough hộp 30 viên điều trị ho do họng và phế quản bị kích thích',
    id: 'D03',
    unit: 'hộp',
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    price: 51.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/10029/248829/soscough-h-30v-mac-dinh-2-700x467.jpg',
    type: 'A1',
  ),
  Drug(
    brought: 134,
    rating: 5.0,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Giloba cải thiện trí nhớ, tuần hoàn máu não',
    fullName: 'Giloba 40mg hộp 30 viên cải thiện trí nhớ, tuần hoàn máu não',
    id: 'D04',
    unit: 'hộp',
    price: 115.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/10033/131220/giloba-40mg-2-1-700x467.jpg',
    type: 'A1',
  ),
  Drug(
    brought: 34,
    rating: 3.8,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Viên Garlic Oil tiêu hóa, ngừa cảm cúm',
    fullName:
        'Viên dầu tỏi UBB Garlic Oil trợ tiêu hóa, ngừa cảm cúm hộp 100 viên',
    id: 'D05',
    unit: 'chai',
    price: 180.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/7016/131210/garlic-oil-ubb-100v-2-1-700x467.jpg',
    type: 'A1',
  ),
  Drug(
    brought: 561,
    rating: 4.5,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Kehl điều trị, giải độc bệnh gan',
    fullName: 'Kehl hộp 60 viên hỗ trợ điều trị bệnh gan, giải độc gan, bổ gan',
    id: 'D06',
    unit: 'hộp',
    price: 150.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/7027/200632/thuoc-ho-tro-dieu-tri-cac-benh-ly-ve-gan-kehl-60-v-2-700x467.jpg',
    type: 'A1',
  ),
  //Medical Devices/Equipments
  Drug(
    brought: 20,
    rating: 4.3,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Khẩu trang y tế HQGano 4 lớp',
    fullName: 'Khẩu trang y tế HQGano 4 lớp màu trắng kháng khuẩn hộp 30 chiếc',
    id: 'D11',
    unit: 'hộp',
    price: 85.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/5872/231731/khau-trang-y-te-hqgano-4-lop-h-30-quai-3d-mac-dinh-2-700x467.jpg',
    type: 'A2',
  ),
  Drug(
    brought: 39,
    rating: 2.0,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Nhiệt kế điện tử Omron TH398S',
    fullName:
        'Nhiệt kế điện tử đo tai chuẩn đoán nhanh và chính xác Omron TH398S',
    id: 'D12',
    unit: 'cái',
    price: 790.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/9922/184379/nhiet-ke-do-tai-omron-th839s-2-700x467.jpg',
    type: 'A2',
  ),
  Drug(
    brought: 86,
    rating: 1.2,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Vớ đùi y khoa Medi Duomed size M',
    fullName: 'Vớ đùi y khoa Medi Duomed size M hỗ trợ trị suy giãn tĩnh mạch',
    id: 'D13',
    unit: 'hộp',
    price: 930.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/9922/195794/vo-y-khoa-ho-tro-dieu-tri-gian-tinh-mach-dui-m-2-1-700x467.jpg',
    type: 'A2',
  ),
  Drug(
    brought: 76,
    rating: 3.5,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Đai băng vải Vantelin Back Support size M',
    fullName: 'Đai băng vải Vantelin Back Support size M dùng bảo vệ cột sống',
    id: 'D16',
    unit: 'hộp',
    price: 750.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/9922/221055/vantelin-back-support-size-m-2-700x467.jpg',
    type: 'A2',
  ),
  Drug(
    brought: 103,
    rating: 4.7,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Bao đeo đầu gối Dr. Med DR-K021 size M',
    fullName:
        'Bao đeo đầu gối đàn hồi Dr. Med DR-K021 size M phòng chấn thương',
    id: 'D17',
    unit: 'hộp',
    price: 249.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/9922/276346/bao-deo-dau-goi-dr-med-dr-k021-size-m-1-700x467.jpg',
    type: 'A2',
  ),
  Drug(
    brought: 61,
    rating: 4.0,
    ingredients:
        'Mỗi 5 ml siro chứa: Hoạt chất: Paracetamol 120 mg, Phenylephrin HCl 5 mg, Chlorpheniramin maleat 1 mg. Tá dược: Glycerin, natri saccharin, màu đỏ số 40',
    uses:
        'Làm giảm các triệu chứng cảm thông thường: nghẹt mũi, hạ sốt, giảm đau và viêm mũi dị ứng.',
    title: 'Que thử đường huyết Accu-Chek Active',
    fullName:
        'Que thử đường huyết cho kết quả nhanh Accu-Chek Active hộp 25 que',
    id: 'D06',
    unit: 'hộp',
    price: 150.000,
    imgUrl:
        'https://cdn.thegioididong.com/Products/Images/9922/275656/que-thu-duong-huyet-accu-chek-active-25-que-1-700x467.jpg',
    type: 'A2',
  ),
];
