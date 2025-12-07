package utils;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class DateHelper {
	 public static String formatVN(Date date) {
	        if (date == null) return "";
	        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	        return sdf.format(date);
	    }
	 
	 public static String formatDateTime(LocalDateTime date) {
		    if (date == null) return "";
		    return date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		}
}
