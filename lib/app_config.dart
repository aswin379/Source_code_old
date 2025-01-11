var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text = "@ Unik Creations " + this_year;
  static String app_name = "PARINAYAM";

  // enter string purchase_code here
  static String purshase_code = '568e369b-06e4-4360-b028-5f0ebbae9282';

  // configure this
  // static const bool HTTPS = false;
  static const bool HTTPS = true;

  static const DOMAIN_PATH =
      "parinayam.kvns.org"; //localhost
  //static const DOMAIN_PATH = "192.168.88.146/matrimonial"; //localhost

  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
