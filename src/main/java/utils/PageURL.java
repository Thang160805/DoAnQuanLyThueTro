package utils;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

public class PageURL {
	public static String buildPageUrl(HttpServletRequest request, int page, String servletName) {
	    StringBuilder url = new StringBuilder(request.getContextPath() + "/" + servletName + "?");

	    Map<String, String[]> params = request.getParameterMap();

	    for (String key : params.keySet()) {
	        if (key.equals("page")) continue;

	        String value = params.get(key)[0];
	        if (value != null && !value.isEmpty()) {
	            url.append(key).append("=").append(value).append("&");
	        }
	    }

	    url.append("page=").append(page);

	    return url.toString();
	}

}
