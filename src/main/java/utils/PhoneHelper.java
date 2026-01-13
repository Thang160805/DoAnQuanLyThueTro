package utils;

public class PhoneHelper {
	public static String maskPhone(String phone) {
	    if (phone == null) return "";

	    phone = phone.replaceAll("\\D", "");

	    if (phone.length() != 10) return phone;

	    return phone.substring(0, 2)
	         + "xx.xxx.xxx"; 
	}
}
