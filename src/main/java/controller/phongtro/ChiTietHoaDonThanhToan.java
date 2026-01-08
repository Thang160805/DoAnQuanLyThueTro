package controller.phongtro;

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
import model.bo.TaiKhoanBO;

import java.io.IOException;

/**
 * Servlet implementation class ChiTietHoaDonThanhToan
 */
@WebServlet("/ChiTietHoaDonThanhToan")
public class ChiTietHoaDonThanhToan extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChiTietHoaDonThanhToan() {
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
		HoaDon hd = hdBO.getHoaDonThanhToanById(idHoaDon);
		request.setAttribute("ChiTietHoaDon", hd);
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan tk = tkBO.getThongTinCaNhan(user.getId());
		request.setAttribute("ThongTin", tk);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/ChiTietHoaDonThanhToan.jsp");
		rs.forward(request, response);
	}

}
