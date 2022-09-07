const String PROTOCOL = "http";
const String PORT = "8000";
const String DOMAIN =  "172.16.41.2"; // acer
//const String DOMAIN = "192.168.1.7";  // lenovo
//const String BASE_URL = "https://gmppat.loca.lt/api/main/pat";
const String BASE_URL =  "$PROTOCOL://$DOMAIN:$PORT/api"; 

const String LOGIN_URL = "$BASE_URL/worker-login";
const String VERIFY_OTP = "$BASE_URL/verify-otp";

const String HOME_PAGE = "$BASE_URL/get-today-works";