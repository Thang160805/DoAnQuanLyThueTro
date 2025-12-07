package utils;

import java.security.MessageDigest;

public class HashUtil {
	public static String md5(String password) {
	    try {
	        MessageDigest md = MessageDigest.getInstance("MD5"); // đổi SHA-256 → MD5
	        byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
	        StringBuilder sb = new StringBuilder();
	        
	        for (byte b : hashBytes) {
	            sb.append(String.format("%02x", b)); // byte → hex
	        }
	        
	        return sb.toString();
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    }
	}
}
