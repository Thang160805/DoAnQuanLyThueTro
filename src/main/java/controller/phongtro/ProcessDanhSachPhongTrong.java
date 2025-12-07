package controller.phongtro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.KhuVuc;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.KhuVucBO;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ProcessDanhSachPhongTrong
 */
@WebServlet(name = "DanhSachPhongTrong", urlPatterns = { "/DanhSachPhongTrong" })
public class ProcessDanhSachPhongTrong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessDanhSachPhongTrong() {
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
		PhongTroBO ptBO = new PhongTroBO();
		String filter="";
		String KhuVuc = request.getParameter("KhuVuc");
		if (KhuVuc == null || KhuVuc.equals("all")) {
		    filter = "and ID_KhuVuc IS NOT NULL";
		}
		else{
			filter = "and ID_KhuVuc ="+KhuVuc;
		}
		
		String GiaThue = (String) request.getParameter("GiaThue");
		if(GiaThue != null) {
			filter = "and GiaThue <="+GiaThue;
		}
		
		String DienTich = request.getParameter("DienTich");
		if(DienTich != null) {
			filter = "and DienTich <="+DienTich;
		}
		
		
		
		int pageSize = 12;
		String pageStr = request.getParameter("page");
		int totalCount = ptBO.getTotalCountsPhongTrong(filter);
		int totalPage = (int) Math.ceil(totalCount * 1.0 / pageSize);
		int page;
		try { 
			page = Integer.parseInt(pageStr); 
		} catch (Exception e) { 
				page = 1; 
		}
		if (page <= 0 || page > totalPage) page = 1;
		
		ArrayList<PhongTro> listPhongTrong = ptBO.getListPhongTroTrong(filter,page);
		request.setAttribute("listPhongTrong", listPhongTrong);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalCount", totalCount);
		
		KhuVucBO kvBO = new KhuVucBO();
		ArrayList<KhuVuc> listKhucVuc = kvBO.getListKhuVuc();
		request.setAttribute("listKhucVuc", listKhucVuc);
		
		ThongBaoBO tbBO = new ThongBaoBO();
		int countTB = tbBO.getCountThongBao(user.getId());
		request.setAttribute("countTB", countTB);
		ArrayList<ThongBao> listTB = tbBO.getTop3TB(user.getId());
		request.setAttribute("listTB", listTB);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/TatCaPhongTrong.jsp");
		rs.forward(request, response);
	}

}
