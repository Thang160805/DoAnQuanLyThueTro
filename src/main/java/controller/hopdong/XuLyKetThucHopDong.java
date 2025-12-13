package controller.hopdong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.HopDongBO;
import model.bo.PhongTroBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class XuLyKetThucHopDong
 */
@WebServlet("/XuLyKetThucHopDong")
public class XuLyKetThucHopDong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyKetThucHopDong() {
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

	    int idHopDong = Integer.parseInt(request.getParameter("ID_HopDong"));
	    int idPhong = Integer.parseInt(request.getParameter("ID_Phong"));
	    int idNguoiThue = Integer.parseInt(request.getParameter("ID_NguoiThue"));
	    String TenPhong = request.getParameter("TenPhong");
	    String title = "Hợp đồng thuê phòng đã kết thúc";

	    String content = "Hợp đồng thuê phòng " + TenPhong + " đã được kết thúc.";

	    String full_content =
	            "Hợp đồng thuê phòng \"" + TenPhong + "\" đã được kết thúc thành công.\n"
	          + "Phòng hiện đã được cập nhật trạng thái \"Còn trống\".";

	    String type = "important";
	    ThongBaoBO tbBO = new ThongBaoBO();
		ThongBao tb = new ThongBao();
		tb.setReceiver_id(idNguoiThue);
		tb.setSender_id(user.getId());
		tb.setTitle(title);
		tb.setContent(content);
		tb.setType(type);
		tb.setFull_content(full_content);
	    HopDongBO hdBO = new HopDongBO();
	    PhongTroBO ptBO = new PhongTroBO();
	    boolean ok1 = hdBO.CapNhatTrangThaiHD(idHopDong);
	    boolean ok2 = ptBO.CapNhatTrangThaiPhong(idPhong);

	    if (ok1 && ok2) {
	    	tbBO.insertGuiThongBao(tb);
	        out.print("{\"success\":true}");
	    } else {
	        out.print("{\"success\":false,\"message\":\"Không thể kết thúc hợp đồng\"}");
	    }
	}

}
