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
import model.bean.TienIch;
import model.bo.KhuVucBO;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;
import model.bo.TienIchBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ProcessTimPhong
 */
@WebServlet(name = "TimPhong", urlPatterns = { "/TimPhong" })
public class ProcessTimPhong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessTimPhong() {
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
		String orderBy = (String) request.getParameter("orderBy");
		String order = (String) request.getParameter("order");
		String filter="";
		String KhuVuc = request.getParameter("KhuVuc");
		if (KhuVuc == null || KhuVuc.equals("all")) {
		    filter = "and pt.ID_KhuVuc IS NOT NULL";
		}
		else{
			filter = "and pt.ID_KhuVuc ="+KhuVuc;
		}
		String keyword = request.getParameter("keyword");
		if(keyword != null) {
			filter = "and (pt.TenPhong like N'%"+keyword+"%' or pt.DiaChi like N'%"+keyword+"%')";
		}
		

		String GiaThue = (String) request.getParameter("GiaThue");
		if(GiaThue != null && !GiaThue.isEmpty()) {
		    filter = "AND pt.GiaThue <= " + GiaThue;
		}
		
		String DienTich = request.getParameter("DienTich");
		if(DienTich != null && !DienTich.isEmpty()) {
		    filter = "AND pt.DienTich <= " + DienTich;
		}
		
		String[] tienIch = request.getParameterValues("TienIch");

		if (tienIch != null && tienIch.length > 0) {

		    String listIds = String.join(",", tienIch);
		    int count = tienIch.length;

		    filter = "AND pt.ID_Phong IN (" +
		              "SELECT pti.Id_Phong " +
		              "FROM PhongTro_TienIch pti " +
		              "WHERE pti.Id_Tienich IN (" + listIds +") " +
		              "GROUP BY pti.Id_Phong " +
		              "HAVING COUNT(DISTINCT pti.Id_Tienich) = " + count +
		              ")";
		}
		int ToTalCountKV = ptBO.getToTalCountKV();
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
		ArrayList<PhongTro> listPhongTro = ptBO.getListPhongTro(orderBy, order, filter, page);
		request.setAttribute("listPhongTro", listPhongTro);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("totalCountKV", ToTalCountKV);
		KhuVucBO kvBO = new KhuVucBO();
		ArrayList<KhuVuc> listKhuVuc = kvBO.getListKhuVucSoPhong();
		request.setAttribute("listKhuVuc", listKhuVuc);
		
		TienIchBO tiBO = new TienIchBO();
		ArrayList<TienIch> listTienIch = tiBO.getListTienIch();
		request.setAttribute("listTienIch", listTienIch);
		
		ThongBaoBO tbBO = new ThongBaoBO();
		int countTB = tbBO.getCountThongBao(user.getId());
		request.setAttribute("countTB", countTB);
		ArrayList<ThongBao> listTB = tbBO.getTop3TB(user.getId());
		request.setAttribute("listTB", listTB);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/TimPhong.jsp");
		rs.forward(request, response);
	}

}
