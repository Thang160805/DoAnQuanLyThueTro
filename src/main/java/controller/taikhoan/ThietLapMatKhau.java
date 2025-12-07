package controller.taikhoan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bo.TaiKhoanBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class ThietLapMatKhau
 */
@WebServlet("/ThietLapMatKhau")
public class ThietLapMatKhau extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThietLapMatKhau() {
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
        PrintWriter out = response.getWriter();
        String TenDangNhap = request.getParameter("TenDangNhap");
        String Password = request.getParameter("password");
        String Confirm_Pass = request.getParameter("confirmPassword");
        
        if (Password == null || Password.trim().isEmpty()) {
            out.print("{\"status\":\"error\", \"message\":\"Mật khẩu không được để trống\"}");
            return;
        }
        if (Confirm_Pass == null || Confirm_Pass.trim().isEmpty()) {
            out.print("{\"status\":\"error\", \"message\":\"Xác nhận mật khẩu không được để trống\"}");
            return;
        }
        
        if (!Confirm_Pass.equals(Password)) {
            out.print("{\"status\":\"error\", \"message\":\"Mật khẩu không khớp!\"}");
            return;
        }
        
        TaiKhoanBO tkBO = new TaiKhoanBO();
        boolean updated = tkBO.DoiMatKhau(TenDangNhap, Password);
        
        if(updated){
            out.print("{\"status\":\"success\", \"message\":\"Đổi mật khẩu thành công!\"}");
        } else {
            out.print("{\"status\":\"error\", \"message\":\"Đổi mật khẩu thất bại!\"}");
        }

	}

}
