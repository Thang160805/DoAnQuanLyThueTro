package controller.taikhoan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.bean.TaiKhoan;
import model.bo.TaiKhoanBO;
import utils.HashUtil;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class DangKyServlet
 */
@WebServlet("/DangKyServlet")
public class DangKyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangKyServlet() {
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
	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String TenDangNhap = request.getParameter("username");
		String roleParam = request.getParameter("role");
		String Password = request.getParameter("password");
		String confirm_pass = request.getParameter("confirm-pass");

		TaiKhoanBO tkBO = new TaiKhoanBO();
		int role = 2;

		try {
		    if (roleParam != null && !roleParam.isEmpty()) {
		        role = Integer.parseInt(roleParam);
		    }
		} catch (NumberFormatException e) {
		    role = 2;
		}
		if (role < 0 || role > 2) {
		    role = 2;
		}

		if (TenDangNhap == null || TenDangNhap.trim().isEmpty()) {
		    out.write("{\"status\":\"error\", \"message\":\"Tên đăng nhập không được để trống\"}");
		    return;
		}

		if (Password == null || Password.length() < 6) {
		    out.write("{\"status\":\"error\", \"message\":\"Mật khẩu phải tối thiểu 6 ký tự\"}");
		    return;
		}

		if (confirm_pass == null || confirm_pass.trim().isEmpty()) {
		    out.write("{\"status\":\"error\", \"message\":\"Xác nhận mật khẩu không được để trống\"}");
		    return;
		}

		if (!Password.equals(confirm_pass)) {
		    out.write("{\"status\":\"error\", \"message\":\"Mật khẩu không khớp\"}");
		    return;
		}

		if (tkBO.checkUserName(TenDangNhap)) {
		    out.write("{\"status\":\"error\", \"message\":\"Tên đăng nhập đã tồn tại\"}");
		    return;
		}

		TaiKhoan tk = new TaiKhoan();
		tk.setTenDangNhap(TenDangNhap);
		tk.setMatKhau(Password);
		tk.setRole(role);

		try {
		    boolean created = tkBO.insertTaiKhoan(tk);

		    if (created) {
		        String url = request.getContextPath() + "/auth/DangNhap.jsp";
		        out.write("{\"status\":\"success\", \"redirect\":\"" + url + "\"}");
		    } else {
		        out.write("{\"status\":\"error\", \"message\":\"Lỗi khi tạo tài khoản\"}");
		    }

		} catch (Exception e) {
		    e.printStackTrace();
		    out.write("{\"status\":\"error\", \"message\":\"Lỗi hệ thống: " + e.getMessage() + "\"}");
		}
	}

}
