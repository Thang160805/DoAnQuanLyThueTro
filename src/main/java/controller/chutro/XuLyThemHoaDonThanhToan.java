package controller.chutro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HoaDon;
import model.bean.HopDong;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.HoaDonBO;
import model.bo.HopDongBO;
import model.bo.ThongBaoBO;
import utils.CurrencyHelper;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

/**
 * Servlet implementation class XuLyThemHoaDonThanhToan
 */
@WebServlet("/XuLyThemHoaDonThanhToan")
public class XuLyThemHoaDonThanhToan extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public XuLyThemHoaDonThanhToan() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		TaiKhoan user = (TaiKhoan) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int idChuTro = user.getId();
		int idHopDong = Integer.parseInt(request.getParameter("ID_HopDong"));
		String thangNam = request.getParameter("ThangNam");
		String hanThanhToanStr = request.getParameter("HanThanhToan");
		int tienPhong = Integer.parseInt(request.getParameter("TienPhong"));
		int tienDien = Integer.parseInt(request.getParameter("TienDien"));
		int tienNuoc = Integer.parseInt(request.getParameter("TienNuoc"));
		String ghiChu = request.getParameter("GhiChu");
		HopDongBO hopDongBO = new HopDongBO();
		HopDong hd = hopDongBO.getInfoByIdHopDong(idHopDong);
		int idNguoiThue = hd.getID_NguoiThue();
		int idPhong = hd.getID_Phong();
		int tongTien = tienPhong + tienDien + tienNuoc;
		Date hanThanhToan = null;
		if (hanThanhToanStr != null && !hanThanhToanStr.isEmpty()) {
			hanThanhToan = Date.valueOf(hanThanhToanStr);
		}
		Date ngayHienTai = new Date(System.currentTimeMillis());
		if (!hanThanhToan.after(ngayHienTai)) {
		    out.print("{\"success\":false,\"message\":\"Hạn thanh toán phải lớn hơn ngày hiện tại\"}");
		    return;
		}
		String title = "Có hóa đơn thanh toán mới";
		String full_content = "Hóa đơn thanh toán cho kỳ " + thangNam + " đã được tạo với tổng số tiền "
				+ CurrencyHelper.format(tongTien) + " VNĐ. " + "Vui lòng thanh toán trước hạn " + hanThanhToanStr
				+ " để đảm bảo quyền lợi của bạn.";
		HoaDonBO hdBO = new HoaDonBO();
		ThongBaoBO tbBO = new ThongBaoBO();
		HoaDon hoaDon = new HoaDon();
		ThongBao tb = new ThongBao();
		hoaDon.setID_HopDong(idHopDong);
		hoaDon.setID_NguoiThue(idNguoiThue);
		hoaDon.setID_ChuTro(idChuTro);
		hoaDon.setID_Phong(idPhong);
		hoaDon.setThangNam(thangNam);
		hoaDon.setTienPhong(tienPhong);
		hoaDon.setTienDien(tienDien);
		hoaDon.setTienNuoc(tienNuoc);
		hoaDon.setTongTien(tongTien);
		hoaDon.setHanThanhToan(hanThanhToan);
		hoaDon.setGhiChu(ghiChu);

		tb.setSender_id(idChuTro);
		tb.setReceiver_id(idNguoiThue);
		tb.setTitle(title);
		tb.setFull_content(full_content);

		boolean checked = hdBO.themHoaDonThanhToan(hoaDon);
		if (checked) {
			tbBO.insertGuiThongBao(tb);
			out.print("{\"success\": true, \"message\": \"Tạo hóa đơn thanh toán thành công\"}");

		} else {
			out.print("{\"success\": false, \"message\": \"Không thể tạo hóa đơn thanh toán\"}");

		}

	}

}
