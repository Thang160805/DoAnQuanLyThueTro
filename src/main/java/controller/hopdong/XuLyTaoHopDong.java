package controller.hopdong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.HopDong;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.HopDongBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;

/**
 * Servlet implementation class XuLyTaoHopDong
 */
@WebServlet("/XuLyTaoHopDong")
public class XuLyTaoHopDong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyTaoHopDong() {
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
		int idNguoiThue = Integer.parseInt(request.getParameter("ID_NguoiThue"));
		int idChuTro = Integer.parseInt(request.getParameter("ID_ChuTro"));
		int idPhong = Integer.parseInt(request.getParameter("ID_Phong"));

		Date ngayKetThuc = Date.valueOf(request.getParameter("NgayKetThuc"));

		String thoiHan = request.getParameter("ThoiHanThue");
		String ngayThanhToan = request.getParameter("NgayThanhToanHangThang");
		int tongTien = Integer.parseInt(request.getParameter("TongThuBanDau"));
		
		PrintWriter out = response.getWriter();

		String ngayBatDauStr = request.getParameter("NgayBatDau");

		if (ngayBatDauStr == null || ngayBatDauStr.trim().isEmpty()) {
		    out.print("{\"success\":false,\"message\":\"Ngày bắt đầu không được để trống\"}");
		    return;
		}


		Date ngayBatDau = Date.valueOf(ngayBatDauStr);

		Date today = Date.valueOf(LocalDate.now());
		Date maxDate = Date.valueOf(LocalDate.now().plusDays(15));

		if (ngayBatDau.before(today)) {
		    out.print("{\"success\":false,\"message\":\"Ngày bắt đầu không được nhỏ hơn ngày hiện tại\"}");
		    return;
		}

		if (ngayBatDau.after(maxDate)) {
		    out.print("{\"success\":false,\"message\":\"Ngày bắt đầu không được quá 15 ngày kể từ hôm nay\"}");
		    return;
		}

		String tienCocStr = request.getParameter("TienCoc");

		if (tienCocStr == null || tienCocStr.trim().isEmpty()) {
		    out.print("{\"success\":false,\"message\":\"Tiền cọc không được để trống\"}");
		    return;
		}

		if (!tienCocStr.matches("\\d+")) {
		    out.print("{\"success\":false,\"message\":\"Tiền cọc phải là số hợp lệ\"}");
		    return;
		}

		int tienCoc = Integer.parseInt(tienCocStr);

		if (tienCoc < 0) {
		    out.print("{\"success\":false,\"message\":\"Tiền cọc không được nhỏ hơn 0\"}");
		    return;
		}

		String dieuKhoan = request.getParameter("DieuKhoan");

		if (dieuKhoan == null || dieuKhoan.trim().isEmpty()) {
		    out.print("{\"success\":false,\"message\":\"Điều khoản hợp đồng không được để trống\"}");
		    return;
		}
		HopDongBO hdBO = new HopDongBO();
		if (hdBO.phongDaCoHopDong(idPhong)) {
		    out.print("{\"success\":false,\"message\":\"Phòng này đã có hợp đồng đang hiệu lực\"}");
		    return;
		}
		String TenPhong = request.getParameter("TenPhong");
		String title = "Hợp đồng thuê phòng đã được tạo";

		String content = "Hợp đồng thuê cho phòng " + TenPhong + " đã được tạo thành công.";

		String full_content =
		        "Hợp đồng thuê phòng \"" + TenPhong + "\" đã được tạo thành công.\n\n"
		      + "• Ngày bắt đầu: " + ngayBatDau + "\n"
		      + "• Thời hạn thuê: " + thoiHan + "\n"
		      + "• Tiền cọc: " + tienCoc + " VNĐ\n\n"
		      + "Vui lòng kiểm tra chi tiết hợp đồng và thực hiện các bước tiếp theo theo thỏa thuận.";

		String type = "important";
		
			
		ThongBaoBO tbBO = new ThongBaoBO();
		ThongBao tb = new ThongBao();
		tb.setReceiver_id(idNguoiThue);
		tb.setSender_id(idChuTro);
		tb.setTitle(title);
		tb.setContent(content);
		tb.setType(type);
		tb.setFull_content(full_content);
		
		
		HopDong hd = new HopDong();
		hd.setID_NguoiThue(idNguoiThue);
		hd.setID_ChuTro(idChuTro);
		hd.setID_Phong(idPhong);
		hd.setNgayBatDau(ngayBatDau);
		hd.setNgayKetThuc(ngayKetThuc);
		hd.setThoiHanThue(thoiHan);
		hd.setTienCoc(tienCoc);
		hd.setNgayThanhToanHangThang(ngayThanhToan);
		hd.setTongThuBanDau(tongTien);
		hd.setDieuKhoan(dieuKhoan);
		
		boolean success = hdBO.taoHopDongVaCapNhatPhong(hd);
		if (success) {
			tbBO.insertGuiThongBao(tb);
		    out.print("{\"success\":true,\"message\":\"Tạo hợp đồng thành công\"}");
		} else {
		    out.print("{\"success\":false,\"message\":\"Không thể tạo hợp đồng\"}");
		}
	}

}
