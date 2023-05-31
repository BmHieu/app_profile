class BaseResponse {
  Map<String, dynamic>? data;
  BaseResponse(Map<String, dynamic> map) {
    data = map;
  }
}

// class UserResponse extends BaseResponse {
//   User get user => User.fromMap(data!["data"]);
//   UserResponse.fromMap(Map<String, dynamic> map) : super(map);
// }

// class ListProductsResponse extends BaseResponse {
//   List<Product>? _listProducts;

//   int get code => data["code"] as int;
//   int get totalPages {
//     Map<String, dynamic> totalPagesResponse = data!['data'];
//     return totalPagesResponse["totalPages"] as int;
//   }

//   int get totalProduct {
//     Map<String, dynamic> totalProductResponse = data!['data'];
//     return totalProductResponse["totalProduct"] as int;
//   }

//   List<Product> get listProducts {
//     Map<String, dynamic> productResponse = data!['data'];
//     return _listProducts ??
//         (productResponse['products'] as List).map((product) => Product.listFromMap(product)).toList();
//   }

//   ListProductsResponse.fromMap(Map<String, dynamic> map) : super(map);
//   ListProductsResponse.fromDb(this._listProducts) : super({});
// }
