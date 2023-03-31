class BASEURL {
  static String ipAddress = "192.168.1.40";
  static String apiRegister = "http://$ipAddress/medhealth_db/register_api.php";
  static String apiLogin = "http://$ipAddress/medhealth_db/login_api.php";
  static String categoryWithProduct =
      'http://$ipAddress/medhealth_db/get_product_with_category.php';
  static String getProduct = 'http://$ipAddress/medhealth_db/get_product.php';
  static String addToCart = 'http://$ipAddress/medhealth_db/add_to_cart.php';
  static String getProductCart =
      'http://$ipAddress/medhealth_db/get_cart.php?userID=';
  static String updateQuantityProduct =
      'http://$ipAddress/medhealth_db/update_quantity.php';
  static String totalPrice =
      'http://$ipAddress/medhealth_db/get_total_price.php?userID=';
}
