package controller.chutro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.BaoHongBO;
import model.bo.PhongTroBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class HoanThanhBaoHong
 */
@WebServlet("/HoanThanhBaoHong")
public class HoanThanhBaoHong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HoanThanhBaoHong() {
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
		int idBaoHong = Integer.parseInt(request.getParameter("idBaoHong"));
		int idNguoiGui = Integer.parseInt(request.getParameter("idNguoiGui"));
		int idPhong = Integer.parseInt(request.getParameter("idPhong"));
		String title = "Hoàn thành xử lý báo hỏng";

		String full_content = "Sự cố bạn đã báo đã được xử lý và khắc phục hoàn tất. "
		        + "Phòng của bạn hiện đã hoạt động bình thường trở lại. "
		        + "Cảm ơn bạn đã phản hồi và hợp tác trong quá trình xử lý.";
		ThongBao tb = new ThongBao();
		tb.setSender_id(user.getId());
		tb.setReceiver_id(idNguoiGui);
		tb.setTitle(title);
		tb.setFull_content(full_content);
		PhongTroBO ptBO = new PhongTroBO();
		BaoHongBO bhBO = new BaoHongBO();
		ThongBaoBO tbBO = new ThongBaoBO();
		boolean checked = bhBO.updateTrangThaiHoanThanh(idBaoHong);
		if (checked) {
		    tbBO.insertGuiThongBao(tb);
		    ptBO.updateTrangThaiPhongSuaHT(idPhong);
		    out.print("{\"success\": true, \"message\": \"Đã hoàn thành xử lý báo hỏng\"}");
		} else {
		    out.print("{\"success\": false, \"message\": \"Không thể hoàn thành xử lý báo hỏng\"}");
		}
	}

}
