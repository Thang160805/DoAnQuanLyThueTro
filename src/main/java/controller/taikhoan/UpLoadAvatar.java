package controller.taikhoan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.bean.TaiKhoan;
import model.bo.TaiKhoanBO;
import utils.ImagesHelper;

import java.io.File;
import java.io.IOException;

/**
 * Servlet implementation class UpLoadAvatar
 */
@WebServlet("/UpLoadAvatar")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,  // 1 MB
	    maxFileSize = 1024 * 1024 * 10,   // 10 MB
	    maxRequestSize = 1024 * 1024 * 50 // 50 MB
	)
public class UpLoadAvatar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpLoadAvatar() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        Part filePart = request.getPart("avatar");

        String newAvatar = ImagesHelper.saveNewAvatar(filePart, getServletContext());

        if (newAvatar == null) {
            response.getWriter().print("{\"status\":\"error\", \"message\":\"Bạn chưa chọn ảnh\"}");
            return;
        }

        TaiKhoanBO tkBO = new TaiKhoanBO();
        boolean exists = tkBO.existsThongTinNguoiDungById(user.getId());
        



        boolean success;
        if (!exists) {
            success = tkBO.insertAnh(user.getId(), newAvatar);
        } else {
            success = tkBO.updateAvatar(user.getId(), newAvatar);
        }

        if (success) {
            user.setAvatar(newAvatar);
            response.getWriter().print("{\"status\":\"success\", \"newAvatar\":\"" + newAvatar + "\"}");
        } else {
            response.getWriter().print("{\"status\":\"error\", \"message\":\"Cập nhật ảnh thất bại\"}");
        }

       
	}

}
