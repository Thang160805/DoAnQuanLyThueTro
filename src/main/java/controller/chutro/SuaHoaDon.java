package controller.chutro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HoaDon;
import model.bean.TaiKhoan;
import model.bo.HoaDonBO;

import java.io.IOException;

/**
 * Servlet implementation class SuaHoaDon
 */
@WebServlet("/SuaHoaDon")
public class SuaHoaDon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuaHoaDon() {
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
		int idHoaDon = Integer.parseInt(request.getParameter("id"));
		HoaDonBO hdBO = new HoaDonBO();
		HoaDon hd = hdBO.getChiTietHoaDonById(idHoaDon);
		request.setAttribute("ChiTietHoaDon", hd);
		
		RequestDispatcher rs = request.getRequestDispatcher("/ChuTro/SuaHoaDon.jsp");
		rs.forward(request, response);
	}

}
