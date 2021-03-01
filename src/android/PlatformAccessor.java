import java.util.Locale; // Для получения языка устройства
import android.provider.Settings.Secure; // Для получения id устройства
// Для получения серийного номера устройства
import android.os.Build;
import android.os.Handler; // Для работы с WebView т.к. с ним нужно работать в другом "потоке"
import java.lang.reflect.Method;

import android.webkit.WebView;
import android.webkit.WebSettings;

import org.apache.cordova.*;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class PlatformAccessor extends CordovaPlugin {
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		// JSONObject arg0 = args.optJSONObject(0);
		
        if( action.equals("getLang") ){
            this.getLang(callbackContext);

            return true;
        }
        else if( action.equals("getUid") ){
            this.getUid(callbackContext);

            return true;
        }
        else if( action.equals("getPlatformData") ){
            this.getPlatformData(callbackContext);

            return true;
        }
        else if( action.equals("minimize") ){
            this.minimize(callbackContext);

            return true;
        }
		else if( action.equals("initWebView") ){
			this.initWebView(callbackContext);
			
            return true;
        }
		
        return false;
    }
	
	
    private void getLang(CallbackContext callbackContext) {
        callbackContext.success(this._getLang());
    }

        private String _getLang() {
            return Locale.getDefault().getLanguage();
        }

    private void getUid(CallbackContext callbackContext) {
        callbackContext.success(this._getUid());
    }

        private String _getUid() {
            String uid = (String) Secure.getString(this.cordova.getActivity().getContentResolver(), Secure.ANDROID_ID); // For android 8.0+ (API level >= 26)
			
            if( uid.equals("") || uid.toLowerCase().equals("unknown") )
                uid = "";
			
			if( uid.equals("") )
				uid = this._getSerialNumber(); // For android 7.1 - (API level <= 25)
			
            return uid;
        }

			private String _getSerialNumber() {
				String serialNumber = "";
				
				try {
					serialNumber = Build.SERIAL; // Was deprecated in API level 26
					
					if (serialNumber.equals("") || serialNumber.toLowerCase().equals("unknown"))
						serialNumber = "";
				} catch (Exception e) {
					serialNumber = "";
				}
				
				if (serialNumber.equals("")){
					try {
						Class<?> c = Class.forName("android.os.SystemProperties");
						Method get = c.getMethod("get", String.class);
						
						serialNumber = (String) get.invoke(c, "gsm.sn1");
						
						if (serialNumber.equals("") || serialNumber.toLowerCase().equals("unknown"))
							serialNumber = (String) get.invoke(c, "ril.serialnumber");
						if (serialNumber.equals("") || serialNumber.toLowerCase().equals("unknown"))
							serialNumber = (String) get.invoke(c, "ro.serialno");
						if (serialNumber.equals("") || serialNumber.toLowerCase().equals("unknown"))
							serialNumber = (String) get.invoke(c, "sys.serialnumber");
					} catch (Exception e) {
						serialNumber = "";
					}
				}
				
				if (serialNumber.equals("") || serialNumber.toLowerCase().equals("unknown"))
					serialNumber = "";
				
				return serialNumber;
			}
		
    private void getPlatformData(CallbackContext callbackContext) {
        JSONObject result = new JSONObject();
        
        try{
            result.put("lang", this._getLang());
            result.put("platformName", "an");
            result.put("platformCode", "8");

            callbackContext.success(result);
        } catch (Exception e) {}
    }
    
    private void minimize(CallbackContext callbackContext) {
        this.cordova.getActivity().moveTaskToBack(true);
    }
	
	private void initWebView(CallbackContext callbackContext) {
		try {
			final CordovaWebView cordovaWebView = webView;
			
			Handler mainHandler = new Handler(cordova.getActivity().getMainLooper());
			
			mainHandler.post(new Runnable() { // Необходимо работать с webView в отдельном "потоке".
				@Override
				public void run() {
					WebView webView = (WebView)cordovaWebView.getView();
					
					WebSettings settings = webView.getSettings();
					
					settings.setTextZoom(100) ;
					
					callbackContext.success("");
				}
			});

		}
		catch (Throwable e) {
			callbackContext.error(e.getMessage());
		}
    }
}