package utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

public class ImagesHelper {
	public static String saveNewAvatar(Part filePart, ServletContext context) {
	    try {
	        if (filePart == null || filePart.getSize() == 0) {
	            return null;
	        }

	        String fileName = System.currentTimeMillis() + "_" + 
	                Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

	        String contextPath = context.getRealPath("");
	        String uploadFolder = contextPath + File.separator + "assets" + File.separator + "img";

	        File uploadDir = new File(uploadFolder);
	        if (!uploadDir.exists()) uploadDir.mkdirs();

	        filePart.write(uploadFolder + File.separator + fileName);

	        return "assets/img/" + fileName;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
}

