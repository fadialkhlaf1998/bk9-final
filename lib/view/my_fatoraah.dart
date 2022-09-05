import 'package:bk9/const/app-style.dart';
import 'package:bk9/controller/cart_contoller.dart';
import 'package:bk9/controller/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'package:myfatoorah_flutter/utils/MFRecurringType.dart';

final String mAPIKey = "yUd5rqv3CII614FlIE-agxC_s6DJ8t_zhsS_rNGCj9hVcj_vTAEZRrVmBqvXVDIfXZvTaMjnqOSTKp0dXLwIeTC0eJHjesHtGRDqSrOimQPoWnCIAKJT7mcU5DDgEcGX-WNPz-q_cDtr5xmp5U9InkBpfivHTW2Ikzwqj1u8bty3KjOk7Zge_VBFtgvCKuoFbi7WofwstOOLUkeqnYp7ORkhcdKqIKRlgzPzWFkPkSOqXF2_7-F8O28Ca07pAxT3-OGaB41R_X9dO8MDuBKRMXWMhj5fbaHVZ5I0---SRY4g2jVJmTLGvzDVilLID8f5CGM90kWlZhYVhsGcekXI7wX9g8EA2At-8zb6fyE02Ac-e5I5o2EYAV2Tx-dKnIQtrmirRJUtyP3EE3VdgGb-o4VNmG9BbKvBnU9EHyRaemCoDc-z5UJPQ0esPixQZcSvMsP9v3VfYqJqIFJH4t_dfso3eMtvjBxHPltIh2zJBcYyCoGaUNbiVoRNdinuSirhY6DjSbkwf2xm3fgcLPaahTI_ILVSh8E6zY2RnW91g9z_29IApxLxufQAQNxSjgDEZ1IV2IJE2HtcnRpXvnOIy8EjjkrKfw0jLJqNb3ndTMwacfJzSiiiablLUsz97uxD-ZKaYhxwCLw3TdhgDtDChHTDS2k79pd3eqsfbAILyTACqH7O";
class MyFatoraahPage extends StatefulWidget {

  MyFatoraahPage(this.title,this.total);

  final String title;
  final String total;

  @override
  _MyHomePageState createState() => _MyHomePageState(total);
}

class _MyHomePageState extends State<MyFatoraahPage> {

  _MyHomePageState(this.amount);

  CartController cartController = Get.find();

  String _response = '';
  String _loading = "Loading...";

  List<PaymentMethods> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;

  String amount = "0.100";
  String cardNumber = "5453010000095489";
  String expiryMonth = "5";
  String expiryYear = "21";
  String securityCode = "100";
  String cardHolderName = "Mahmoud Ibrahim";
  bool visibilityObs = false;
  MFPaymentCardView? mfPaymentCardView;
  CheckoutController checkoutController = Get.find();
  @override
  void initState() {
    super.initState();

    if (mAPIKey.isEmpty) {
      setState(() {
        _response =
        "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(mAPIKey, MFCountry.UNITED_ARAB_EMIRATES, MFEnvironment.LIVE);
    // (Optional) un comment the following lines if you want to set up properties of AppBar.

//    MFSDK.setUpAppBar(
//      title: "MyFatoorah Payment",
//      titleColor: Colors.white,  // Color(0xFFFFFFFF)
//      backgroundColor: Colors.black, // Color(0xFF000000)
//      isShowAppBar: true); // For Android platform only

    // (Optional) un comment this line, if you want to hide the AppBar.
    // Note, if the platform is iOS, this line will not affected

//    MFSDK.setUpAppBar(isShowAppBar: false);

    initiatePayment();
    initiateSession();
  }

  /*
    Send Payment
   */
  void sendPayment() {
    var request = MFSendPaymentRequest(
        invoiceValue: double.parse(amount),
        customerName: "Customer name",
        notificationOption: MFNotificationOption.LINK);

    /*var invoiceItem =
        new InvoiceItem(itemName: "item1", quantity: 1, unitPrice: 0.100);
    var listItems = new List<InvoiceItem>();
    listItems.add(invoiceItem);
    request.invoiceItems = listItems;*/

    MFSDK.sendPayment(
        context,
        MFAPILanguage.EN,
        request,
            (MFResult<MFSendPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response!.toJson());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Initiate Payment
   */
  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(
        double.parse(amount), MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response!.toJson());
                _response = ""; //result.response.toJson().toString();
                paymentMethods.addAll(result.response!.paymentMethods!);
                for (int i = 0; i < paymentMethods.length; i++)
                  isSelected.add(false);
              })
            }
          else
            {
              setState(() {
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Regular Payment
   */
  void executeRegularPayment(int paymentMethodId) {
    var request =
    new MFExecutePaymentRequest(paymentMethodId, double.parse(amount));

    // For recurring
    // request?.recurringModel = RecurringModel(MFRecurringType.monthly, iteration: 5);

    MFSDK.executePayment(
        context,
        request,

        MFAPILanguage.EN,
           onPaymentResponse:  (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              //todo sucss msg
              setState(() {
                // Get.back();
                print('********My Fatorah Fadi*******');
                        checkoutController.addOrder(context, 1);
                print(invoiceId);
                print(result.response!.toJson());
                _response = result.response!.toJson().toString();
              })



            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment
   */
  void executeDirectPayment(int paymentMethodId) {
    var request =
    new MFExecutePaymentRequest(paymentMethodId, double.parse(amount));

//    var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        securityCode: securityCode,
        cardHolderName: cardHolderName,
        bypass3DS: false,
        saveToken: false);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response!.toJson());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment with Recurring
   */
  void executeDirectPaymentWithRecurring() {
    // The value 20 is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 20;

    var request =
    new MFExecutePaymentRequest(paymentMethod, double.parse(amount));

    var mfCardInfo = new MFCardInfo(
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        securityCode: securityCode,
        bypass3DS: true,
        saveToken: true);

    MFSDK.executeRecurringDirectPayment(
        context,
        request,
        mfCardInfo,
        MFRecurringType.monthly,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(invoiceId);
                print(result.response!.toJson());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Payment Enquiry
   */
  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: "12345");

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
            (MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response!.toJson());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Token
   */
  void cancelToken() {
    MFSDK.cancelToken(
        "Put your token here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Recurring Payment
   */
  void cancelRecurringPayment() {
    MFSDK.cancelRecurringPayment(
        "Put RecurringId here",
        MFAPILanguage.EN,
            (MFResult<bool> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print(result.response.toString());
                _response = result.response.toString();
              })
            }
          else
            {
              setState(() {
                print(result.error!.toJson());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  void setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods[index].isDirectPayment!;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else
        isSelected[i] = false;
    }
  }

  void pay() {
    if (selectedPaymentMethodIndex == -1) {
      Fluttertoast.showToast(
          msg: "Please select payment method first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      if (amount.isEmpty) {
        Fluttertoast.showToast(
            msg: "Set the amount",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      } else if (paymentMethods[selectedPaymentMethodIndex].isDirectPayment!) {
        if (cardNumber.isEmpty ||
            expiryMonth.isEmpty ||
            expiryYear.isEmpty ||
            securityCode.isEmpty)
          Fluttertoast.showToast(
              msg: "Fill all the card fields",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

        else
          executeDirectPayment(
              paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
      } else
        executeRegularPayment(
            paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
    }
  }

  fun(){
        (MFResult<MFInitiateSessionResponse> result) => {
      if (result.isSuccess())
        {mfPaymentCardView!.load(result.response!)}
      else
        {
          setState(() {
            print(
                "Response: " + result.error!.toJson().toString().toString());
            _response = result.error!.message!;
          })
        }
    };
  }
  void initiateSession() {
    MFSDK.initiateSession(null,(MFResult<MFInitiateSessionResponse> result) => {
      if (result.isSuccess())
        {mfPaymentCardView!.load(result.response!)}
      else
        {
          setState(() {
            print(
                "Response: " + result.error!.toJson().toString().toString());
            _response = result.error!.message!;
          })
        }
    });
  }

  void payWithEmbeddedPayment() {
    var request = MFExecutePaymentRequest.constructor(0.100);
    mfPaymentCardView!.pay(
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                print("invoiceId: " + invoiceId);
                print("Response: " + result.response!.toJson().toString());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print("invoiceId: " + invoiceId);
                print("Error: " + result.error!.toJson().toString());
                _response = result.error!.message!;
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height*0.7-MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TextField(
                  //   keyboardType: TextInputType.number,
                  //   controller: TextEditingController(text: amount),
                  //   decoration: InputDecoration(labelText: "Payment Amount"),
                  //   onChanged: (value) {
                  //     amount = value;
                  //   },
                  // ),
                  Text(amount.toString()),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Text("Select payment method"),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0),
                        itemCount: paymentMethods.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          print(paymentMethods.length);
                          return Column(
                            children: <Widget>[
                              Image.network(paymentMethods[index].imageUrl!,
                                  width: 40.0, height: 40.0),
                              Checkbox(
                                  value: isSelected[index],
                                  onChanged: (value) {
                                    setState(() {
                                      setPaymentMethodSelected(index, value!);
                                    });
                                  })
                            ],
                          );
                        }),
                  ),
                  visibilityObs
                      ? Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(labelText: "Card Number"),
                        controller:
                        TextEditingController(text: cardNumber),
                        onChanged: (value) {
                          cardNumber = value;
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(labelText: "Expiry Month"),
                        controller:
                        TextEditingController(text: expiryMonth),
                        onChanged: (value) {
                          expiryMonth = value;
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(labelText: "Expiry Year"),
                        controller:
                        TextEditingController(text: expiryYear),
                        onChanged: (value) {
                          expiryYear = value;
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(labelText: "Security Code"),
                        controller:
                        TextEditingController(text: securityCode),
                        onChanged: (value) {
                          securityCode = value;
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: "Card Holder Name"),
                        controller:
                        TextEditingController(text: cardHolderName),
                        onChanged: (value) {
                          cardHolderName = value;
                        },
                      ),
                    ],
                  )
                      : Column(),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  TextButton(
                    // color: AppStyle.primary,
                    // textColor: Colors.white,
                    child: Text('Pay'),
                    onPressed: pay,
                  ),
                  // RaisedButton(
                  //   color: Colors.lightBlue,
                  //   textColor: Colors.white,
                  //   child: Text('Send Payment'),
                  //   onPressed: sendPayment,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  // ),
                  // createPaymentCardView(),
                  // RaisedButton(
                  //   color: Colors.lightBlue,
                  //   textColor: Colors.white,
                  //   child: Text('Pay (Embedded Payment)'),
                  //   onPressed: payWithEmbeddedPayment,
                  // ),
                  // Text(_response),
                ]),
          ),
        ),
      ),
    );
  }

  createPaymentCardView() {
    mfPaymentCardView = MFPaymentCardView(
     inputColor: Colors.red,
     labelColor: Colors.yellow,
     errorColor: Colors.blue,
     borderColor: Colors.green,
     fontSize: 14,
     borderWidth: 1,
     borderRadius: 10,
     cardHeight: 220,
     cardHolderNameHint: "card holder name hint",
     cardNumberHint: "card number hint",
     expiryDateHint: "expiry date hint",
     cvvHint: "cvv hint",
     showLabels: true,
     cardHolderNameLabel: "card holder name label",
     cardNumberLabel: "card number label",
     expiryDateLabel: "expiry date label",
     cvvLabel: "cvv label",
    );

    return mfPaymentCardView;
  }


}