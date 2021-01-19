// All Constant Variable Go Here
String serverLink="http://farmer-oh-farmer.herokuapp.com/api/";
//String serverLink="http://192.168.57.181:8080/api/";
String loginApi = serverLink + "customer/loginCustomer";
String signUpApi = serverLink + "customer/addCustomer";
String searchFarmerByLocationApi =
    serverLink + "customer/searchFarmerByLocation";
String getProductsFromFarmerApi = serverLink + "customer/getProductsFromFarmer";
String addProductToCartApi = serverLink + "customer/addProductToCart";
String getCartProductsApi = serverLink + "customer/getCartProducts";
String placeOrderApi = serverLink + "customer/placeOrder";

//
const String SUCCESSFLAG = "Success";
const String FAILEDFLAG = "Failed";
