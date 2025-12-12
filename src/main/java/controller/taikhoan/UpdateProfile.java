package controller.taikhoan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.TaiKhoanBO;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 * Servlet implementation class UpdateProfile
 */
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateProfile() {
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
		TaiKhoanBO tkBO = new TaiKhoanBO();
		String hoTen = request.getParameter("HoTen");
		String cccd = request.getParameter("CCCD");
		String sdt = request.getParameter("SDT");
		String email = request.getParameter("Email");
		String diaChi = request.getParameter("DiaChi");
		String nsStr = request.getParameter("NgaySinh");

		java.sql.Date ngaySinh = null;
		if (nsStr != null && !nsStr.isEmpty()) {
			ngaySinh = java.sql.Date.valueOf(nsStr);
		}

		if (hoTen == null || hoTen.trim().isEmpty()) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Họ tên không được để trống\"}");
			return;
		}

		if (!hoTen.matches("^[\\p{L} .'-]+$")) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Họ tên không hợp lệ\"}");
			return;
		}

		if (cccd == null || cccd.trim().isEmpty()) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"CCCD không được để trống\"}");
			return;
		}

		if (!cccd.matches("\\d+")) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"CCCD không được nhập chữ\"}");
			return;
		}
		if (sdt == null || sdt.trim().isEmpty()) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Số điện thoại không được để trống\"}");
			return;
		}
		if (sdt.length() < 9 || sdt.length() > 11) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Số điện thoại không hợp lệ\"}");
			return;
		}

		if (sdt != null && !sdt.trim().isEmpty() && !sdt.matches("\\d+")) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Số điện thoại không được nhập chữ\"}");
			return;
		}

		if (email == null || email.trim().isEmpty()) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Email không được để trống\"}");
			return;
		}

		if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Email không hợp lệ\"}");
			return;
		}

		String gtStr = request.getParameter("GioiTinh");
		int gioiTinh = -1;
		try {
			gioiTinh = Integer.parseInt(gtStr);
		} catch (Exception e) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Giới tính không hợp lệ\"}");
			return;
		}

		if (gioiTinh != 1 && gioiTinh != 2) {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Giới tính không hợp lệ\"}");
			return;
		}
		TaiKhoan tk = new TaiKhoan();
		tk.setHoTen(hoTen);
		tk.setCCCD(cccd);
		tk.setSDT(sdt);
		tk.setEmail(email);
		tk.setDiaChi(diaChi);
		tk.setNgaySinh(ngaySinh);
		tk.setGioiTinh(gioiTinh);
		tk.setId(user.getId());
		boolean updated = tkBO.updateThongTinCaNhan(tk);
		if (updated) {
			response.getWriter().print("{\"status\":\"success\",\"message\":\"Cập nhật thông tin thành công\"}");
		} else {
			response.getWriter().print("{\"status\":\"error\",\"message\":\"Cập nhật thất bại\"}");
		}
		

	}

}
