package utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;

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
	
	public static String saveRoomImage(Part filePart, ServletContext context) {
	    try {
	        if (filePart == null || filePart.getSize() == 0) {
	            return null;
	        }

	        String fileName = System.currentTimeMillis() + "_" +
	                Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

	        
	        String uploadPath = context.getRealPath("") + File.separator + "assets" + File.separator + "img";

	        File folder = new File(uploadPath);
	        if (!folder.exists()) folder.mkdirs();

	        filePart.write(uploadPath + File.separator + fileName);

	        return "assets/img/" + fileName;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public static ArrayList<String> saveMultipleRoomImages(Collection<Part> fileParts, ServletContext context) {
	    ArrayList<String> list = new ArrayList<>();

	    for (Part part : fileParts) {
	        if (part.getName().equals("anhPhuList[]") && part.getSize() > 0) {
	            String fileName = System.currentTimeMillis() + "_" +
	                    Paths.get(part.getSubmittedFileName()).getFileName().toString();

	            String uploadPath = context.getRealPath("") + File.separator + "assets" + File.separator + "img";

	            File folder = new File(uploadPath);
	            if (!folder.exists()) folder.mkdirs();

	            try {
	                part.write(uploadPath + File.separator + fileName);
	                list.add("assets/img/" + fileName);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    return list;
	}


}

