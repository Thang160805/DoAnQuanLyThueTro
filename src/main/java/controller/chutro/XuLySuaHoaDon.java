package controller.chutro;

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
import java.io.PrintWriter;
import java.sql.Date;

/**
 * Servlet implementation class XuLySuaHoaDon
 */
@WebServlet("/XuLySuaHoaDon")
public class XuLySuaHoaDon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLySuaHoaDon() {
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
		int idHoaDon = Integer.parseInt(request.getParameter("id"));
		String thangNam = request.getParameter("thangNam");
		String hanThanhToanStr = request.getParameter("hanThanhToan");
		int tienPhong = Integer.parseInt(request.getParameter("TienPhong"));
		int tienDien = Integer.parseInt(request.getParameter("TienDien"));
		int tienNuoc = Integer.parseInt(request.getParameter("TienNuoc"));
		int tongTien = tienPhong + tienDien + tienNuoc;
		String ghiChu = request.getParameter("ghiChu");
		Date hanThanhToan = null;
		if (hanThanhToanStr != null && !hanThanhToanStr.isEmpty()) {
			hanThanhToan = Date.valueOf(hanThanhToanStr);
		}
		Date ngayHienTai = new Date(System.currentTimeMillis());
		if (!hanThanhToan.after(ngayHienTai)) {
		    out.print("{\"success\":false,\"message\":\"Hạn thanh toán phải lớn hơn ngày hiện tại\"}");
		    return;
		}
		HoaDonBO hdBO = new HoaDonBO();
		HoaDon hoaDon = new HoaDon();
		hoaDon.setId(idHoaDon);
		hoaDon.setThangNam(thangNam);
		hoaDon.setTienDien(tienDien);
		hoaDon.setTienNuoc(tienNuoc);
		hoaDon.setTongTien(tongTien);
		hoaDon.setHanThanhToan(hanThanhToan);
		hoaDon.setGhiChu(ghiChu);
		boolean checked = hdBO.updateHoaDon(hoaDon);
		if (checked) {
		    out.print("{\"success\": true, \"message\": \"Cập nhật hóa đơn thành công\"}");
		} else {
		    out.print("{\"success\": false, \"message\": \"Không thể cập nhật hóa đơn\"}");
		}

	}

}
