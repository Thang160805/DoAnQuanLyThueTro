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
		TaiKhoan oldInfo = tkBO.getThongTinCaNhan(user.getId());

		String hoTen = getValue(request.getParameter("HoTen"), oldInfo.getHoTen());
		String cccd = getValue(request.getParameter("CCCD"), oldInfo.getCCCD());
		String sdt = getValue(request.getParameter("SDT"), oldInfo.getSDT());
		String gioiTinhStr = request.getParameter("GioiTinh");
		int newGender = -1;

		if (gioiTinhStr != null && !gioiTinhStr.trim().isEmpty()) {
		    newGender = Integer.parseInt(gioiTinhStr);
		}

		int gioiTinh = getValueInt(newGender, oldInfo.getGioiTinh());
		String nsStr = request.getParameter("NgaySinh");
		Date newDate = null;

		if (nsStr != null && !nsStr.trim().isEmpty()) {
		    try {
		        newDate = Date.valueOf(nsStr);
		    } catch (Exception e) {
		        newDate = null;
		    }
		}

		Date ngaySinh = safeDate(newDate, oldInfo.getNgaySinh());
		String diaChi = getValue(request.getParameter("DiaChi"), oldInfo.getDiaChi());
		
		
		TaiKhoan tk = new TaiKhoan(user.getId(),hoTen,sdt,cccd,diaChi,ngaySinh,gioiTinh);
		boolean exists = tkBO.existsThongTinNguoiDungById(user.getId());
		if(!exists) {
			boolean created = tkBO.insertThongTinNguoiDung(tk);
			if (created) {
		        response.getWriter().print("{\"status\":\"success\",\"message\":\"Thêm thông tin thành công\"}");
		    } else {
		        response.getWriter().print("{\"status\":\"error\",\"message\":\"Thêm thông tin thất bại\"}");
		    }
		    return;
		}else {
			boolean updated = tkBO.updateThongTinCaNhan(tk);
			if (updated) {
		        response.getWriter().print("{\"status\":\"success\",\"message\":\"Cập nhật thông tin thành công\"}");
		    } else {
		        response.getWriter().print("{\"status\":\"error\",\"message\":\"Cập nhật thất bại\"}");
		    }
		    return;
		}
		

		
	}
	
	private String getValue(String newVal, String oldVal) {
        return (newVal == null || newVal.trim().isEmpty()) ? oldVal : newVal;
    }
	
	private int getValueInt(int newVal, int oldVal) {
	    return (newVal == -1) ? oldVal : newVal;
	}
	
	private Date safeDate(Date newDate, Date oldDate) {
	    return (newDate == null) ? oldDate : newDate;
	}

}
