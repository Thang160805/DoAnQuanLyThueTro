package controller.chutro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.YeuCauThueTro;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.YeuCauThueTroBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class QuanLyTro
 */
@WebServlet("/QuanLyTro")
public class QuanLyTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLyTro() {
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
		TaiKhoan tk = tkBO.getThongTinCaNhan(user.getId());
		request.setAttribute("ThongTinCaNhan", tk);
		
		PhongTroBO ptBO = new PhongTroBO();
		ArrayList<PhongTro> listPhongTro = ptBO.getListPhongByIDChuTro(user.getId());
		request.setAttribute("listPT", listPhongTro);
		
		int countSoPhong = ptBO.getCountSoPhongByIDChutro(user.getId());
		request.setAttribute("countSoPhong", countSoPhong);
		int countPhongTrong = ptBO.getCountSoPhongTrongByIDCT(user.getId());
		request.setAttribute("countPhongTrong", countPhongTrong);
		int countPhongDaThue = ptBO.getCountSoPhongDaThueByIDCT(user.getId());
		request.setAttribute("countPhongDaThue", countPhongDaThue);
		
		YeuCauThueTroBO ycBO = new YeuCauThueTroBO();
		ArrayList<YeuCauThueTro> listYeuCau = ycBO.getListYeuCau();
		request.setAttribute("listYeuCau", listYeuCau);
		int count = ycBO.getCountYeuCau();
		request.setAttribute("countYC", count);
		RequestDispatcher rs = request.getRequestDispatcher("/ChuTro/QuanLyTro.jsp");
		rs.forward(request, response);
	}

}
