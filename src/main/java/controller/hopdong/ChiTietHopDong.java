package controller.hopdong;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HopDong;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.TienIch;
import model.bo.HopDongBO;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.TienIchBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ChiTietHopDong
 */
@WebServlet("/ChiTietHopDong")
public class ChiTietHopDong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChiTietHopDong() {
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
		int id = Integer.parseInt(request.getParameter("id"));
		int idNguoiThue = Integer.parseInt(request.getParameter("ID_NguoiThue"));
		int idChuTro   = Integer.parseInt(request.getParameter("ID_ChuTro"));
		int idPhong    = Integer.parseInt(request.getParameter("ID_Phong"));
		PhongTroBO ptBO = new PhongTroBO();
		PhongTro pt = ptBO.getPhongTroById(idPhong);
		request.setAttribute("ChiTietPhong", pt);
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan tkNguoiThue = tkBO.getThongTinCaNhan(idNguoiThue);
		request.setAttribute("TaiKhoanNguoiThue", tkNguoiThue);
		TaiKhoan tkChuTro = tkBO.getThongTinCaNhan(idChuTro);
		request.setAttribute("TaiKhoanChuTro", tkChuTro);
		
		TienIchBO tiBO = new TienIchBO();
		ArrayList<TienIch> list = tiBO.getListTienIchByIDPhong(idPhong);
		request.setAttribute("listTienIch", list);
		HopDongBO hdBO = new HopDongBO();
		HopDong hd = hdBO.getHopDongByID(id);
		request.setAttribute("ChiTietHD", hd);
		RequestDispatcher rs = request.getRequestDispatcher("/HopDong/ChiTietHopDong.jsp");
		rs.forward(request, response);
	}

}
