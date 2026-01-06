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
 * Servlet implementation class DangNhapServlet
 */
@WebServlet("/DangNhapServlet")
public class DangNhapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangNhapServlet() {
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
		response.setContentType("application/json; charset=UTF-8");

		HttpSession session = request.getSession();
		session.setAttribute("user", request.getAttribute("user"));

		int role = (Integer) request.getAttribute("Role");
		System.out.println(role);

		String url = "";

		if (role == 1) {
		    url = request.getContextPath() + "/QuanLyTro";
		} 
		else if (role == 2) {
		    url = request.getContextPath() + "/ProcessHomeUser";
		} else if(role==0) {
			url = request.getContextPath() + "/AdminQT";
		}
		else {
		    url = request.getContextPath() + "/user/login.jsp?error=role";
		}

		response.getWriter().write("{\"status\":\"success\", \"redirect\":\"" + url + "\"}");

	}

}
