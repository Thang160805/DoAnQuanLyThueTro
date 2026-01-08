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
import model.bean.ThongBao;
import model.bo.HoaDonBO;
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class LichThanhToan
 */
@WebServlet("/LichThanhToan")
public class LichThanhToan extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LichThanhToan() {
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
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan ThongTin = tkBO.getThongTinCaNhan(user.getId());
		request.setAttribute("ThongTinCaNhan", ThongTin);
		ThongBaoBO tbBO = new ThongBaoBO();
		int countTB = tbBO.getCountThongBao(user.getId());
		request.setAttribute("countTB", countTB);
		ArrayList<ThongBao> listTB = tbBO.getTop3TB(user.getId());
		request.setAttribute("listTB", listTB);
		
		HoaDonBO hdBO = new HoaDonBO();
		int TotalCountTB = hdBO.getTotalCountListHDById(user.getId());

		int pageSize = 4;
		int totalPage = (int) Math.ceil(TotalCountTB * 1.0 / pageSize);
		String pageStr = request.getParameter("page");
		int page;
		try {
			page = Integer.parseInt(pageStr);
		} catch (Exception e) {
			page = 1;
		}
		if (page <= 0 || page > totalPage)
			page = 1;
		hdBO.capNhatHoaDonTreHan();
		ArrayList<HoaDon> listHD = hdBO.getHoaDonByID_NguoiThue(user.getId(), page);
		request.setAttribute("listHD", listHD);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalCount", TotalCountTB);
		
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/LichThanhToan.jsp");
		rs.forward(request, response);
	}

}
