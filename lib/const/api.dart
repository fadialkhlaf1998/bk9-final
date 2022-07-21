import 'dart:convert';
import 'package:bk9/const/store.dart';
import 'package:bk9/model/address.dart';
import 'package:bk9/model/brand.dart';
import 'package:bk9/model/customer.dart';
import 'package:bk9/model/cart_item.dart';
import 'package:bk9/model/customer_order.dart';
import 'package:bk9/model/order_items.dart';
import 'package:bk9/model/post.dart';
import 'package:bk9/model/start_up.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class API {
  static String url = "https://phpstack-548447-2508399.cloudwaysapps.com";
  static String media_url = url + "/uploads/";
  static int customer_id = -1;
  static String company_id = "";
  static String email = "";
  static String password = "";
  static bool is_active = false;
  static String cookie = "";
  static Customer? customer;
  static String public_key = "6Md5Hi31ooTfpzJOUP76fVTM8DPsD5Zcq6v9TFsIxrlCnvf7sG";
  static String startUpKey = "7126dcfd5f2fdf83c0bca1b0b647f424172a78d818ad1508f0b78748378dfb914a9fc8cede2f525bab9f50ea02add1b030552f135c24fba09a4afa27182827c23e2c2b15cb676cf112e7280e4e97f82aa25853b1f05d4e9ba702625957eec1c93901";

  ///StartUp
  static Future<int> getCompanyId() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url + '/api/app-key-web'));
    request.body = json.encode({"public_key": public_key});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsondata = json.decode(data);
      company_id = jsondata["company_id"];
      return 1;
    } else {
      return -1;
    }
  }
  static Future<int> getCompanyIdTo() async {
    print('--*****---');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url + '/api/app-key'));
    request.body = json.encode({"public_key": public_key});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      cookie = response.headers["set-cookie"].toString();
      var data = await response.stream.bytesToString();
      var jsondata = json.decode(data);
      // print(jsondata);
      return jsondata["company_id"];
    } else {
      print(response.reasonPhrase);
      return -1;
    }
  }
  static Future<StartUp?> startUp() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url + '/api/start-up-k9-web'));
    request.body = json.encode({
      "customer_id": customer_id,
      "company_id": startUpKey,
      "locale": Store.languageCode
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // print(data);
      StartUp startUp = StartUp.fromJson(data);
      return startUp;
    } else {
      return null;
    }
  }

  ///ProductInfo
  static Future<Products?> getProductInfo(int id) async {
    var headers = {
      'api-key': startUpKey,
      'locale': Store.languageCode,
      'customer-id': '1',
    };
    var request = http.Request('GET', Uri.parse(url + '/api/productInfo/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);
      // print(data);
      return Products.fromMap(jsonData);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  ///shop by brand
  static Future<List<BrandInfo>?> getProductsByBrand(int brandId) async {
    var headers = {
      'api-key': startUpKey,
      'locale': Store.languageCode,
    };

    var request = http.Request('GET', Uri.parse(url + '/api/shopByBrand/'+brandId.toString()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      print(data);
      return Brand.fromMap(jsonDecode(data)).brandInfo;
    }
    else {
      return <BrandInfo>[];
    }

  }

  ///cart
  static Future<bool> deleteFromCart(int cart_id)async{
    var request = http.Request('DELETE', Uri.parse(url + '/api/v2/cart/'+cart_id.toString()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    }
    else {
    print(response.reasonPhrase);
    return false;
    }
  }
  static Future<List<CartItem>?> addToCart(int productOptionId,int count) async {
    if(customer_id != -1) {
      var headers = {'Content-Type': 'application/json', };
      var request = http.Request('POST', Uri.parse(url + '/api/v2/add-to-cart'));
      request.body = json.encode({
        "customer_id": customer_id,
        "product_options_id": productOptionId,
        "count": count
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        // print(data);
        return CartItems.fromMap(jsonDecode(data)).cart;
      } else {
        print(response.reasonPhrase);
        return <CartItem>[];
      }
    }else {
      return <CartItem>[];
    }
  }
  static Future<List<CartItem>> getCart(int customerId) async {
    var request = http.Request('GET', Uri.parse(url + '/api/v2/cart/'+customerId.toString()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // print(data);
      return CartItems.fromMap(jsonDecode(data)).cart!;
    }
    else {
      print(response.reasonPhrase);
      return <CartItem>[];
    }
  }

  /// address
  static Future<bool> setAddressDefault(int addressId)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url + '/api/address/default'));
    request.body = json.encode({
      "customer_id": customer!.id,
      "id": addressId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<List<Address>> getAddress()async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('GET', Uri.parse(url + '/api/address/${customer!.id}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return Addresses.fromMap(jsonDecode(data)).address!;
    }
    else {
      print(response.reasonPhrase);
      return <Address>[];
    }

  }
  static Future<bool> deleteAddress(int addressId)async{
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url + "/api/address"));
    request.body = json.encode({"id": addressId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> addAddress(String nickName,int isDefault,String address1,String address2,String apartment,String phone,String country,String emirate)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + '/api/address'));
    request.body = json.encode({
      "customer_id": customer_id,
      "first_name": nickName,
      "last_name": "",
      "is_default": isDefault,
      "email": customer!.email,
      "address_1": address1,
      "address_2": address2,
      "apartment": apartment,
      "phone": phone,
      "country": country,
      "state": emirate
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> editAddress(String nickName,int isDefault,String address1,String address2,String apartment,String phone,String country,String emirate,int addressId)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url + '/api/address'));
    request.body = json.encode({
      "first_name": nickName,
      "last_name": "",
      "is_default": isDefault,
      "email": customer!.email,
      "address_1": address1,
      "address_2": address2,
      "apartment": apartment,
      "phone": phone,
      "country": country,
      "state": emirate,
      "id" : addressId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  ///wishlist
  static Future<List<Post>> getWishlist(int customerId) async {
    if (customer_id != -1) {
      var headers = {'Content-Type': 'application/json',};
      var request = http.Request('Get', Uri.parse(url + '/api/wishlist/'+customerId.toString()));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        // print(data);
        return PostDecoder.fromMap(jsonDecode(data)).posts;
      } else {
        return <Post>[];
      }
    } else {
      return <Post>[];
    }
  }
  static Future<bool> addToWishlist(int postId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url + '/api/add-wishlist'));
    request.body = json.encode({
      "customer_id": customer_id,
      "post_id": postId
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      print(data);
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> deleteFromWishlist(int postId) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
    http.Request('DELETE', Uri.parse(url + '/api/wishlist'));
    request.body = json.encode({
      "customer_id": customer_id,
      "post_id": postId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ///order
  static Future<bool> addOrder(String nickName, String address1, String address2, String phone, String country, String emirate, double total, double subTotal, double shipping, double discount, int isPaid, List<CartItem> cart) async {
    var headers = {'Content-Type': 'application/json',};
    var request = http.Request('POST', Uri.parse(url + '/api/v2/order'));
    request.body = json.encode({
      "customer_id": customer_id,
      "first_name": nickName,
      "last_name": "",
      "address_1": address1,
      "address_2": address2,
      "phone": phone,
      "country": country,
      "state": emirate,
      "order_state": 0,
      "is_paid": isPaid,
      "total": total,
      "sub_total": subTotal,
      "shipping": shipping,
      "discount": discount,
      "isPaid" : isPaid,
      "lineItems": List<dynamic>.from(cart.map((x) => x.toMap()))
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    } else {
      return false;
    }
  }
  static Future<List<CustomerOrder>> getCustomerOrders(int customerId) async {
    var headers = {'Content-Type': 'application/json',};
    var request = http.Request('Get', Uri.parse(url + '/api/v2/customer_orders/'+customerId.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // print(data);
      return Order.fromMap(jsonDecode(data)).customerOrder!;
    } else {
      return <CustomerOrder>[];
    }
  }
  static Future<List<OrderItem>> orderItems(int orderId) async {
    var headers = {
      'api-key': startUpKey,
      'locale': Store.languageCode,
    };
    var request = http.Request('GET', Uri.parse(url + '/api/v2/order-items/'+ orderId.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // print(data);
      return OrderItems.fromMap(jsonDecode(data)).orderItems;
    } else {
      return <OrderItem>[];
    }
  }

  /// checkInternet
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  /// SignUp & LogIn & Verify & ResendCode & ForgetPassword & ChangePassword
  static Future<bool> signUp(String name, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url + '/api/v2/customer-signup'));
    request.body = json.encode({
      "firstname": name,
      "lastname": "",
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      Store.saveLogInInfo(email, password, 1.toString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<Customer?> login() async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + '/api/v2/customer-login'));
    request.body = json.encode({
      "email": email,
      "password": password
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      Customer customer = Customer.fromMap(jsonDecode(data));
      customer_id = customer.id;
      Store.saveLogInInfo(email, password,customer_id.toString());
      Store.saveActive(true);
      API.customer = customer;
      return customer;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
  static Future<bool> verify(String email, String code) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + '/api/v2/customer-verify-email'));
    request.body = json.encode({
      "email": email,
      "code": code
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      Store.saveActive(true);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> resendCode(String email) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + '/api/v2/resend-code'));
    request.body = json.encode({
      "email": email,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> forgot_password(String email) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + '/api/v2/customer-forgot-password'));
    request.body = json.encode({"email": email,"id": customer_id});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> change_password(String new_password) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request =
    http.Request('PUT', Uri.parse(url + '/api/v2/customer-change-password'));
    request.body = json.encode({"password": new_password, "id": customer_id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      password = new_password;
      Store.saveLogInInfo(email, password, 1.toString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> upload_customer_photo(String path) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.MultipartRequest(
        'PUT', Uri.parse(url + '/api/v2/customer-upload-image'));
    request.fields.addAll({'id': customer_id.toString()});
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> delete_customer_photo(int id) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url + '/api/v2/customer-delete-image'));
    request.body = json.encode({
      "id": id
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

}