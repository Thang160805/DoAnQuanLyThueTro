package utils;

public class CurrencyHelper {
	public static String format(int amount) {
	    String str = String.valueOf(amount);
	    int cnt = 0;
	    String res = "";
	    for (int i = str.length() - 1; i >= 0; i--) {
	        cnt++;
	        res = str.charAt(i) + res;
	        if (cnt % 3 == 0 && i != 0) { 
	            res = "." + res;
	        }
	    }
	    return res;
	}
	
	public static String format1(float amount) {
	    String str = String.valueOf(amount);
	    int cnt = 0;
	    String res = "";
	    for (int i = str.length() - 1; i >= 0; i--) {
	        cnt++;
	        res = str.charAt(i) + res;
	        if (cnt % 3 == 0 && i != 0) { 
	            res = "." + res;
	        }
	    }
	    return res;
	}
}
