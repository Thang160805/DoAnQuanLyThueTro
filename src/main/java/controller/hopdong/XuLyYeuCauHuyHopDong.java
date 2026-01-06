package controller.hopdong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class XuLyYeuCauHuyHopDong
 */
@WebServlet("/XuLyYeuCauHuyHopDong")
public class XuLyYeuCauHuyHopDong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyYeuCauHuyHopDong() {
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
		int ID_HopDong = Integer.parseInt(request.getParameter("idHopDong"));
		int ID_ChuTro = Integer.parseInt(request.getParameter("idChuTro"));
		String TenPhong = request.getParameter("tenPhong");

		String title = "Có yêu cầu hủy hợp đồng mới";
		String full_content =
		        "Người thuê đã gửi yêu cầu hủy hợp đồng #" + ID_HopDong +
		        " cho phòng \"" + TenPhong + "\".\n"
		      + "Vui lòng xem xét và xử lý yêu cầu trong thời gian sớm nhất.";
		String type = "important";

		ThongBaoBO tbBO = new ThongBaoBO();
		ThongBao tb = new ThongBao();
		tb.setReceiver_id(ID_ChuTro);
		tb.setSender_id(user.getId());
		tb.setTitle(title);
		tb.setType(type);
		tb.setFull_content(full_content);
		tbBO.insertGuiThongBao(tb);
		out.print("{\"success\": true}");
	}

}
