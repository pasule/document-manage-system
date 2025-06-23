package com.manage.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class JstlFunctions {
    public static String formatLocalDateTime(LocalDateTime dateTime, String pattern) {
        if (dateTime == null) return "";
        return dateTime.format(DateTimeFormatter.ofPattern(pattern));
    }
} 