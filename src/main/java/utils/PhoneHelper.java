package utils;

public class PhoneHelper {
	public static String maskPhone(String phone) {
	    if (phone == null) return "";

	    phone = phone.replaceAll("\\D", ""); // bỏ ký tự không phải số

	    if (phone.length() != 10) return phone; // không đúng 10 số thì trả lại nguyên

	    return phone.substring(0, 2)        // 08
	         + "xx.xxx.xxx";                // xx.xxx.xxx
	}
}
