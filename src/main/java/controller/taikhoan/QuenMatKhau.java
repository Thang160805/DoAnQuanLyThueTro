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
import java.io.PrintWriter;

/**
 * Servlet implementation class QuenMatKhau
 */
@WebServlet("/QuenMatKhau")
public class QuenMatKhau extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuenMatKhau() {
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
        if (TenDangNhap == null || TenDangNhap.trim().isEmpty()) {
            out.print("{\"status\":\"error\", \"message\":\"Tên đăng nhập không được để trống\"}");
            return;
        }
        TaiKhoanBO tkBO = new TaiKhoanBO();
        boolean check = tkBO.checkUserName(TenDangNhap);
        if (check) {
            out.print("{\"status\":\"success\", \"TenDangNhap\":\"" + TenDangNhap + "\"}");
        } else {
            out.print("{\"status\":\"error\", \"message\":\"Tài khoản không tồn tại\"}");
        }
	}

}
