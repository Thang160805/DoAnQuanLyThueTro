package controller.taikhoan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.TaiKhoanBO;

import java.io.IOException;

/**
 * Servlet implementation class ChangePass
 */
@WebServlet("/ChangePass")
public class ChangePass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePass() {
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
		HttpSession session = request.getSession();
		
		TaiKhoan user = (TaiKhoan) session.getAttribute("user");
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/index.jsp");
		    return;
		}
		response.setContentType("application/json;charset=UTF-8");
		
		 int userID = user.getId(); // <-- Lấy từ session, không từ Ajax

	        String currentPass = request.getParameter("CurrentPass");
	        String newPass = request.getParameter("NewPass");
	        String confirmPass = request.getParameter("ConfirmPass");
	        
	        if (currentPass == null || currentPass.trim().isEmpty()) {
	            response.getWriter().print("{\"status\":\"error\",\"message\":\"Mật khẩu hiện tại không được để trống\"}");
	            return;
	        }

	        if (newPass == null || newPass.trim().isEmpty()) {
	            response.getWriter().print("{\"status\":\"error\",\"message\":\"Mật khẩu mới không được để trống\"}");
	            return;
	        }

	        if (confirmPass == null || confirmPass.trim().isEmpty()) {
	            response.getWriter().print("{\"status\":\"error\",\"message\":\"Xác nhận mật khẩu không được để trống\"}");
	            return;
	        }
	        TaiKhoanBO tkBO = new TaiKhoanBO();
	        boolean checkPass = tkBO.checkPassword(userID, currentPass);
	        if(!checkPass) {
	        	response.getWriter().print("{\"status\":\"error\",\"message\":\"Mật khẩu không đúng\"}");
	            return;
	        }
	        
	        if (!newPass.equals(confirmPass)) {
	            response.getWriter().print("{\"status\":\"error\",\"message\":\"Mật khẩu nhập lại không khớp\"}");
	            return;
	        }
	        
	        boolean update = tkBO.ChangePass(userID, newPass);
	        if (update) {
	            response.getWriter().print("{\"status\":\"success\",\"message\":\"Đổi mật khẩu thành công\"}");
	        } else {
	            response.getWriter().print("{\"status\":\"error\",\"message\":\"Đổi mật khẩu thất bại\"}");
	        }
	}

}
