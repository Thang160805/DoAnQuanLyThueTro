package utils;

import java.time.Duration;
import java.time.LocalDateTime;

public class TimeHelper {
	public static String timeAgo(LocalDateTime dateTime) {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(dateTime, now);

        long seconds = duration.getSeconds();
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;
        long weeks = days / 7;
        long months = days / 30;
        long years = days / 365;

        if (seconds < 60) {
            return "Vừa xong";
        } else if (minutes < 60) {
            return minutes + " phút trước";
        } else if (hours < 24) {
            return hours + " giờ trước";
        } else if (days < 7) {
            return days + " ngày trước";
        } else if (weeks < 4) {
            return weeks + " tuần trước";
        } else if (months < 12) {
            return months + " tháng trước";
        } else {
            return years + " năm trước";
        }
    }
}
