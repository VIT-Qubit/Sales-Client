const String PROTOCOL = "http";
const String PORT = "8000";
const String DOMAIN =  "172.16.42.37"; // acer
//const String DOMAIN = "192.168.1.7";  // lenovo
//const String BASE_URL = "https://gmppat.loca.lt/api/main/pat";
const String BASE_URL =  "$PROTOCOL://$DOMAIN:$PORT/api"; 

const String LOGIN_URL = "$BASE_URL/worker-login";
const String VERIFY_OTP_URL = "$BASE_URL/authenticate-worker";

const String HOME_PAGE_URL = "$BASE_URL/get-today-works";
const String ALL_TASK_URL = "$BASE_URL/get-all-works";
const String UPDATE_TASK_STATUS_URL = "$BASE_URL/update-ticket";
const String RECORDS_INDETAIL_URL = "$BASE_URL/get-ticket-details";
const String PROFILE_URL = "$BASE_URL/get-worker-data";
const String UPDATE_STATUS_URL = "$BASE_URL/update-status";
const String LIVE_LOCATION_URL = "$BASE_URL/update-worker-location-live";