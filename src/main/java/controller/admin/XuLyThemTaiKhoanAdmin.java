package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.TaiKhoanBO;
import utils.HashUtil;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class XuLyThemTaiKhoanAdmin
 */
@WebServlet("/XuLyThemTaiKhoanAdmin")
public class XuLyThemTaiKhoanAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyThemTaiKhoanAdmin() {
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
	    PrintWriter out = response.getWriter();
	    String TenDangNhap = request.getParameter("TenDangNhap");
	    String password = request.getParameter("Password");
	    String confirm  = request.getParameter("Confirm_pass");

	    if(TenDangNhap == null || TenDangNhap.trim().isEmpty()){
	        out.write("{\"success\":false,\"message\":\"Tên đăng nhập không được trống\"}");
	        return;
	    }

	    if(password == null || password.length() < 6){
	        out.write("{\"success\":false,\"message\":\"Mật khẩu tối thiểu 6 ký tự\"}");
	        return;
	    }

	    if(!password.equals(confirm)){
	        out.write("{\"success\":false,\"message\":\"Mật khẩu không khớp\"}");
	        return;
	    }
	    
	    TaiKhoanBO tkBO = new TaiKhoanBO();
	    if (tkBO.checkUserName(TenDangNhap)) {
	    	out.write("{\"success\":false,\"message\":\"Tên đăng nhập đã tồn tại\"}");
		    return;
		}
	    int role=0;
	    String hashedPassword = HashUtil.md5(password);
	    TaiKhoan tk = new TaiKhoan();
		tk.setTenDangNhap(TenDangNhap);
		tk.setMatKhau(hashedPassword);
		tk.setRole(role);
		int ID_TaiKhoan = tkBO.insertTaiKhoanReturnID(tk);
		if (ID_TaiKhoan > 0) {
		    tkBO.insertThongTinNguoiDungMoi(ID_TaiKhoan);
		    out.write("{\"success\":true}");
		} else {
			 out.write("{\"success\":false,\"message\":\"Lỗi khi tạo tài khoản\"}");
		}
	}

}
