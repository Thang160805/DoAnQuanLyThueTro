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
		StringBuilder filter = new StringBuilder(" AND pt.ID_Phong IS NOT NULL ");

		// ===== LỌC THEO KHU VỰC =====
		String khuVuc = request.getParameter("KhuVuc");
		if (khuVuc != null && !khuVuc.equals("all")) {
		    filter.append(" AND pt.ID_KhuVuc = ").append(khuVuc);
		}

		// ===== LỌC THEO TỪ KHÓA =====
		String keyword = request.getParameter("keyword");
		if (keyword != null && !keyword.trim().isEmpty()) {
		    filter.append(" AND (pt.TenPhong LIKE N'%")
		          .append(keyword.trim())
		          .append("%' OR pt.DiaChi LIKE N'%")
		          .append(keyword.trim())
		          .append("%')");
		}

		// ===== LỌC THEO GIÁ (INT) =====
		String giaMinStr = request.getParameter("giaMin");
		String giaMaxStr = request.getParameter("giaMax");

		try {
		    if (giaMinStr != null && !giaMinStr.isEmpty()) {
		        int giaMin = Integer.parseInt(giaMinStr);
		        filter.append(" AND pt.GiaThue >= ").append(giaMin);
		    }

		    if (giaMaxStr != null && !giaMaxStr.isEmpty()) {
		        int giaMax = Integer.parseInt(giaMaxStr);
		        filter.append(" AND pt.GiaThue <= ").append(giaMax);
		    }
		} catch (NumberFormatException e) {
		    request.setAttribute("error", "Giá thuê không hợp lệ");
		}

		// ===== LỌC THEO DIỆN TÍCH (FLOAT) =====
		String dtMinStr = request.getParameter("dtMin");
		String dtMaxStr = request.getParameter("dtMax");

		try {
		    if (dtMinStr != null && !dtMinStr.isEmpty()) {
		        float dtMin = Float.parseFloat(dtMinStr);
		        filter.append(" AND pt.DienTich >= ").append(dtMin);
		    }

		    if (dtMaxStr != null && !dtMaxStr.isEmpty()) {
		        float dtMax = Float.parseFloat(dtMaxStr);
		        filter.append(" AND pt.DienTich <= ").append(dtMax);
		    }
		} catch (NumberFormatException e) {
		    request.setAttribute("error", "Diện tích không hợp lệ");
		}

		// ===== VALIDATE LOGIC (MIN <= MAX) =====
		if (giaMinStr != null && giaMaxStr != null &&
		    !giaMinStr.isEmpty() && !giaMaxStr.isEmpty()) {

		    int giaMin = Integer.parseInt(giaMinStr);
		    int giaMax = Integer.parseInt(giaMaxStr);

		    if (giaMin > giaMax) {
		        request.setAttribute("error",
		            "Giá từ không được lớn hơn giá đến");
		    }
		}

		if (dtMinStr != null && dtMaxStr != null &&
		    !dtMinStr.isEmpty() && !dtMaxStr.isEmpty()) {

		    float dtMin = Float.parseFloat(dtMinStr);
		    float dtMax = Float.parseFloat(dtMaxStr);

		    if (dtMin > dtMax) {
		        request.setAttribute("error",
		            "Diện tích từ không được lớn hơn diện tích đến");
		    }
		}

		// ===== LỌC THEO TIỆN ÍCH (CHECKBOX) =====
		String[] tienIch = request.getParameterValues("TienIch");
		if (tienIch != null && tienIch.length > 0) {

		    String listIds = String.join(",", tienIch);
		    int count = tienIch.length;

		    filter.append(
		        " AND pt.ID_Phong IN ( " +
		        "   SELECT pti.Id_Phong " +
		        "   FROM PhongTro_TienIch pti " +
		        "   WHERE pti.Id_Tienich IN (" + listIds + ") " +
		        "   GROUP BY pti.Id_Phong " +
		        "   HAVING COUNT(DISTINCT pti.Id_Tienich) = " + count +
		        " )"
		    );
		}
		String filterSQL = filter.toString();
		int ToTalCountKV = ptBO.getToTalCountKV();
		int pageSize = 12;
		String pageStr = request.getParameter("page");
		int totalCount = ptBO.getTotalCountsPhongTrong(filterSQL);
		int totalPage = (int) Math.ceil(totalCount * 1.0 / pageSize);
		int page;
		try { 
			page = Integer.parseInt(pageStr); 
		} catch (Exception e) { 
				page = 1; 
		}
		if (page <= 0 || page > totalPage) page = 1;
		ArrayList<PhongTro> listPhongTro = ptBO.getListPhongTro(orderBy, order, filterSQL, page);
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
